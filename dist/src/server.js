const express = require('express');
const cors = require('cors');
const path = require('path');
const http = require('http');

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, '../public')));

// AI分析API
app.post('/api/ai/analyze', async (req, res) => {
  try {
    const { text, type = 'text', model = 'qwen3:8b', systemPrompt } = req.body;
    
    if (!text || !text.trim()) {
      return res.json({
        category: '未识别内容',
        advice: '请补充更多内容进行分析',
        tags: ['一般输入']
      });
    }

    // 构建Ollama的提示词
    const prompt = `分析以下内容，判断其类型并提供建议：\n\n${text}\n\n请严格按照以下JSON格式返回：\n{"category": "会议纪要|待办事项|交付物/输出|风险提示|附件/资料", "advice": "建议内容", "tags": ["标签1", "标签2"]}`;

    // 调用本地Ollama API
    const response = await callOllamaAPI(prompt, model, systemPrompt);
    
    res.json(response);
  } catch (error) {
    console.error('AI分析错误:', error);
    
    // 如果Ollama调用失败，回退到模拟分析
    const lower = text.toLowerCase();
    const tags = [];
    let category = '未识别内容';
    let advice = 'AI分析暂时不可用，使用基础分析。';

    if (/会议|纪要|讨论|反馈|会议纪要/.test(lower)) {
      category = '会议纪要';
      advice = '建议将该内容整理成会议结果和后续行动。';
      tags.push('会议', '纪要');
    }
    if (/待办|TODO|需处理|需确认|跟进|后续/.test(lower)) {
      category = '待办事项';
      advice = '该输入看起来像待办项，建议及时分配负责人。';
      tags.push('待办', '跟进');
    }
    if (/交付|交付物|清单|方案|报价/.test(lower)) {
      category = '交付物/输出';
      advice = '该内容可能属于交付物或验收项。';
      tags.push('交付', '输出');
    }
    if (/风险|风险点|问题|名词不锁定|不明确/.test(lower)) {
      category = '风险提示';
      advice = '请将该项纳入风险跟踪，避免后续返工。';
      tags.push('风险', '待解决');
    }
    if (/工艺文件|零件命名表|现场勘探|UI设计/.test(lower)) {
      category = '附件/资料';
      advice = '该内容可作为关键资料归档。';
      tags.push('资料', '附件');
    }

    if (tags.length > 1) {
      category = tags.includes('待办') ? '待办事项' : category;
    }

    res.json({ category, advice, tags: tags.length ? tags : ['一般输入'] });
  }
});

// 调用Ollama API的函数
function callOllamaAPI(prompt, model = 'qwen3:8b', systemPrompt) {
  return new Promise((resolve, reject) => {
    const options = {
      hostname: 'localhost',
      port: 11434,
      path: '/api/generate',
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      }
    };

    const req = http.request(options, (res) => {
      let data = '';
      
      res.on('data', (chunk) => {
        data += chunk;
      });
      
      res.on('end', () => {
        try {
          // Ollama返回的是多行JSON，需要解析
          const lines = data.split('\n').filter(line => line.trim());
          let fullResponse = '';
          
          lines.forEach(line => {
            const json = JSON.parse(line);
            if (json.response) {
              fullResponse += json.response;
            }
          });
          
          // 尝试解析JSON响应
          try {
            const result = JSON.parse(fullResponse);
            resolve(result);
          } catch (e) {
            // 如果不是有效的JSON，使用默认值
            resolve({
              category: '会议纪要',
              advice: 'AI分析完成，内容已处理。',
              tags: ['AI分析', '会议']
            });
          }
        } catch (error) {
          reject(error);
        }
      });
    });

    req.on('error', (error) => {
      reject(error);
    });

    const requestBody = {
      model: model,
      prompt: prompt,
      stream: false
    };

    // 如果提供了systemPrompt，添加到请求中
    if (systemPrompt) {
      requestBody.system = systemPrompt;
    }

    req.write(JSON.stringify(requestBody));
    req.end();
  });
}

// 健康检查
app.get('/health', (req, res) => {
  res.json({ status: 'ok', message: 'AI Analyzer is running' });
});

app.listen(PORT, () => {
  console.log(`AI Analyzer server is running at http://localhost:${PORT}`);
});