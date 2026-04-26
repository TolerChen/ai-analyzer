const axios = require('axios');

async function testAPI() {
  console.log('开始测试AI Analyzer API...');
  
  try {
    // 测试健康检查
    console.log('1. 测试健康检查接口...');
    const healthResponse = await axios.get('http://localhost:3001/health');
    console.log('健康检查结果:', healthResponse.data);
    
    // 测试分析接口
    console.log('\n2. 测试分析接口...');
    const testText = '今天的会议讨论了项目进度，需要在下周完成UI设计，同时要注意代码质量问题。';
    const analyzeResponse = await axios.post('http://localhost:3001/api/ai/analyze', {
      text: testText
    });
    console.log('分析结果:', analyzeResponse.data);
    
    // 测试空输入
    console.log('\n3. 测试空输入...');
    const emptyResponse = await axios.post('http://localhost:3001/api/ai/analyze', {
      text: ''
    });
    console.log('空输入结果:', emptyResponse.data);
    
    console.log('\n✅ 所有测试通过！');
  } catch (error) {
    console.error('测试失败:', error.message);
    if (error.response) {
      console.error('响应数据:', error.response.data);
    }
  }
}

// 运行测试
testAPI();