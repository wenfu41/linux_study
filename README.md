# Linux 学习助手 (Linux Study App)

这是一个使用 Flutter 开发的 Android 应用程序，旨在帮助用户学习和查询 Linux 命令。

## 功能特点

### 1. 命令大全
- 收录了常用的 Linux 命令。
- 支持通过命令名称、描述或详细解释进行实时搜索。
- 每个命令都包含：
    - **名称**：命令的英文名称。
    - **简介**：简短的功能描述。
    - **详细解释**：详细的中文用法说明。
    - **示例代码**：带有语法高亮的实际使用示例。
    - **注意事项**：常见错误和避坑指南。

### 3. 脚本学习
- 提供 Linux Shell 脚本的基础教程。
- 涵盖变量、循环、条件判断、函数、重定向等核心概念。
- 每个知识点都配有代码示例和详细解释。

### 4. 常用分类
- 将命令按功能进行分类（如文件管理、网络管理、权限管理等）。
- 使用折叠列表展示，方便按类别查找和学习。

### 5. 软件包与练习
- **软件包**：常用 Linux 软件安装指南。
- **练习**：交互式问答，巩固学习成果，支持进度追踪。

### 3. 现代化 UI 设计
- 采用深色模式（Dark Mode），符合极客审美。
- 使用 Material Design 组件，界面流畅美观。
- 代码示例使用 `flutter_highlight` 进行高亮显示。

## 技术栈

- **Flutter**: UI 框架
- **Provider**: 状态管理
- **Google Fonts**: 字体样式
- **Flutter Highlight**: 代码高亮

## 安装与运行

1. 确保已安装 Flutter SDK。
2. 克隆本项目或下载源码。
3. 在项目根目录下运行以下命令安装依赖：
   ```bash
   flutter pub get
   ```
4. 连接 Android 设备或启动模拟器。
5. 运行应用：
   ```bash
   flutter run
   ```

## 项目结构

```
lib/
├── main.dart                  # 程序入口
├── models/                    # 数据模型
│   └── command_model.dart     # LinuxCommand 模型
├── providers/                 # 状态管理
│   └── command_provider.dart  # 命令数据加载与搜索逻辑
├── data/                      # 数据文件
│   └── commands.json          # 预置的命令数据
├── screens/                   # 页面
│   ├── home_screen.dart       # 主页框架
│   ├── command_list_screen.dart # 命令列表页
│   ├── common_commands_screen.dart # 分类浏览页
│   └── command_detail_screen.dart # 命令详情页
├── widgets/                   # 通用组件
│   └── command_card.dart      # 命令卡片组件
└── theme/                     # 主题配置
    └── app_theme.dart         # 应用主题样式
```

## 数据扩展

如果需要添加更多命令，只需编辑 `lib/data/commands.json` 文件，按照现有格式添加新的 JSON 对象即可。
