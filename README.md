# AI Analyzer - 智能分析工具

独立的AI分析工具，支持多种输入方式和智能分析功能。

## 功能特性

- 🤖 **智能分析**：支持会议内容、待办事项、风险问题、交付物等多种类型分析
- 🎤 **语音输入**：集成Web Speech API，支持语音识别
- 📁 **文件上传**：支持多种文件格式（.txt, .md, .js, .py, .json, .csv, .log）
- 🔄 **Ollama集成**：连接本地Ollama服务，提供更智能的分析能力
- 🛠 **备用模式**：当Ollama不可用时自动切换到本地分析模式
- 📊 **结果输出**：提供内容分类、智能建议、关键词标签等分析结果
- 🌐 **API接口**：提供RESTful API，方便嵌入到其他项目

## 快速开始

### 1. 安装依赖

```bash
cd ai-analyzer
npm install
```

### 2. 启动服务

```bash
npm start
```

服务将运行在 `http://localhost:3001`

### 3. 访问演示页面

打开浏览器访问：`http://localhost:3001`

## API接口

### 分析接口

**POST** `/api/ai/analyze`

**请求参数**：
```json
{
  "text": "会议内容或其他文本",
  "type": "text" // 可选，分析类型
}
```

**响应示例**：
```json
{
  "category": "会议纪要",
  "advice": "建议将该内容整理成会议结果和后续行动。",
  "tags": ["会议", "纪要"]
}
```

### 健康检查

**GET** `/health`

**响应示例**：
```json
{
  "status": "ok",
  "message": "AI Analyzer is running"
}
```

## 如何嵌入到其他项目

### 方法1：直接调用API

```javascript
// 示例代码
async function analyzeContent(text) {
  try {
    const response = await fetch('http://localhost:3001/api/ai/analyze', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ text })
    });
    
    if (response.ok) {
      const result = await response.json();
      console.log('分析结果:', result);
      return result;
    }
  } catch (error) {
    console.error('分析失败:', error);
  }
  return null;
}

// 使用示例
const analysisResult = await analyzeContent('今天的会议讨论了项目进度，需要在下周完成UI设计。');
```

### 方法2：集成前端组件

可以将 `public/index.html` 中的相关代码复制到您的项目中，或者使用iframe嵌入：

```html
<iframe src="http://localhost:3001" width="100%" height="600px" frameborder="0"></iframe>
```

## 配置说明

### Ollama设置

1. 安装Ollama：https://ollama.com/
2. 启动Ollama服务：`ollama serve`
3. 拉取模型：`ollama pull qwen3:8b`
4. 确保服务运行在 `http://localhost:11434`

### 端口配置

默认服务端口为3001，可通过环境变量修改：

```bash
PORT=8080 npm start
```

## 技术栈

- **后端**：Node.js + Express
- **前端**：HTML5 + CSS3 + JavaScript
- **AI集成**：Ollama API
- **依赖**：express, cors, axios

## 目录结构

```
ai-analyzer/
├── src/
│   ├── server.js        # 服务器主文件
├── public/
│   ├── index.html       # 演示页面
├── tests/
│   └── test.js          # 测试文件
├── examples/
│   └── sample.txt       # 示例文件
├── package.json         # 项目配置
└── README.md            # 说明文档
```

## 测试

```bash
npm test
```

## 注意事项

1. 确保Ollama服务已启动，否则会自动切换到备用分析模式
2. 对于大型文件，分析可能需要更长时间
3. 语音输入功能需要浏览器支持Web Speech API

## 许可证

MIT
