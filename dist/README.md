# AI Analyzer - AI智能分析工具

## 项目简介

这是一个独立的AI分析工具，支持多种输入方式和智能分析功能。

## 功能特性

- 多种输入方式：手动输入、语音输入、文件上传
- AI身份选择：分析助手、项目经理、项目牧羊人、职场教练、技术专家
- 本地Ollama支持：可连接本地Ollama服务
- 云端API支持：OpenAI、DeepSeek、Anthropic、Azure、智谱AI、Moonshot、通义千问等
- 多API配置管理：可保存和切换多个API配置
- 实时流式输出：像DeepSeek一样实时显示分析过程
- AI身份配置：可自定义AI身份的系统提示词和分析提示词

## 快速开始

### 1. 安装依赖

```bash
npm install
```

### 2. 启动服务器

```bash
npm start
```

或者

```bash
node src/server.js
```

### 3. 访问应用

打开浏览器访问：http://localhost:3001/index.html

## 使用方法

### 配置API

1. 点击右上角的"⚙️ 配置"按钮
2. 点击"+ 添加新接口"添加API配置
3. 选择API提供商（如DeepSeek、OpenAI等）
4. 输入API密钥
5. 选择模型
6. 点击"保存配置"

### 进行分析

1. 选择输入方式：手动输入、语音输入或文件上传
2. 输入要分析的内容
3. 选择AI身份
4. 选择AI服务（本地Ollama或云端API）
5. 点击"AI智能分析"按钮
6. 查看分析结果

### 配置AI身份

1. 访问 config.html 页面
2. 点击"+"按钮添加新的AI身份
3. 设置身份名称、系统提示词和分析提示词
4. 保存配置

## 技术栈

- 前端：HTML5、CSS3、JavaScript
- 后端：Node.js、Express
- AI服务：Ollama、各云端AI API

## 文件结构

```
ai-analyzer/
├── public/
│   ├── index.html      # 主页面
│   └── config.html    # 配置页面
├── src/
│   └── server.js      # 服务器
├── tests/
│   └── test.js        # 测试
├── dist/              # 打包输出
└── package.json       # 项目配置
```

## 注意事项

- 使用云端API需要有效的API密钥
- 使用本地Ollama需要先安装并启动Ollama服务
- 语音输入功能需要浏览器支持Web Speech API
