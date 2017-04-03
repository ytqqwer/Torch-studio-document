# Git 协作指南 | 开发工作流

本文描述使用 Git 进行小组内文档、代码协作的工作流，以及在工作流中需要遵守的各项规范。但并不提及 Git 的使用原理，在提及 Git 相关命令时也不再对其进行详细介绍。在阅读本文档前，请确保你已经阅读过 [廖雪峰的 Git 教程](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)。

---

<!-- TOC depthFrom:2 -->

- [1. 我们的分支模型](#1-我们的分支模型)
- [2. 搭建本地协作环境](#2-搭建本地协作环境)
    - [2.1. 注册 GitHub 帐号](#21-注册-github-帐号)
    - [2.2. 安装和配置本地 Git 客户端](#22-安装和配置本地-git-客户端)
    - [2.3. 安装 clang-format plugin for Visual Studio](#23-安装-clang-format-plugin-for-visual-studio)
- [3. 克隆远程仓库到本地](#3-克隆远程仓库到本地)
- [4. 在本地 commit 并 push](#4-在本地-commit-并-push)
    - [4.1. commit/push 前注意](#41-commitpush-前注意)
    - [4.2. （选项一）使用 Git bash 来 commit](#42-选项一使用-git-bash-来-commit)
    - [4.3. （选项二）使用 Visual Studio 来 commit](#43-选项二使用-visual-studio-来-commit)
    - [4.4. commit msg 书写规范](#44-commit-msg-书写规范)
    - [4.5. push 到 github(origin)](#45-push-到-githuborigin)
- [5. 管理 commit](#5-管理-commit)

<!-- /TOC -->

---

## 1. 我们的分支模型

随着开发进行，可能会对下面描述的分支模型进行一定更改。

// TODO 待商讨
// 单分支，尽量减少 Git 使用负担

## 2. 搭建本地协作环境

本次『工程设计与管理』中，我们使用 Git 来进行小组内文档和代码协作，使用 clang-format 来统一代码风格。

### 2.1. 注册 GitHub 帐号

1. 在 [GitHub](www.github.com) 上注册帐号，注意：

    使用英文 username。如果没有，现在选择一个。

1. 在注册完成并验证邮箱后，完善 GitHub 个人资料。

    在 Settings > Profile > Public profile 下填写 Name 一项后点击 `Update profie` 。开发过程中不要再更改此 Name。

### 2.2. 安装和配置本地 Git 客户端

1. 从 [git 官网](https://git-scm.com/) 上下载 Git for Windows，并以默认选项安装。
1. 熟悉 Git Bash。Git for Windows 自带 `Git Bash` `Git CMD` `Git GUI` 三种用户界面。在本次工程设计中，我们只使用 `Git Bash`。在实际进行 Git 相关操作以前，熟悉 `Git Bash` 并调整的字体大小以及默认窗口大小满意自己喜好。
1. 生成 SSH Key 并添加到自己的 GitHub 帐号中，具体的步骤参见 [廖雪峰的 Git 教程/远程仓库](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/001374385852170d9c7adf13c30429b9660d0eb689dd43a000)。
1. 使用 VS Code 新建文件 `C:\Users\<your-win-username>\.gitconfig`，并填入如下内容（请一字不差的复制，我没有理由害你）：

    在 `name` 一项后面写上你在 Settings > Profile > Public Profile 中填写的 Name，在 `email` 一项后面写上注册 GitHub 时候使用的邮箱。

```
[user]
    name =
    email =
[core]
    editor = code --wait # 使用 vs code 来编辑 commit message。如果没有 vs code，建议装一个
    safecrlf = true # 防止 crlf/lf 混用
    quotepath = false # 防止中文路径乱码
[alias]
    lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
```

### 2.3. 安装 clang-format plugin for Visual Studio

大括号换行的和大括号不换行的打起来怎么办？ (´_ゝ｀)

为了避免上面这种情况，我们使用统一的代码风格。[clang-format](https://clang.llvm.org/docs/ClangFormat.html) 可以跨平台使用，可以集成到各种 IDE 里面，而且使用纯文本形式的代码风格描述方式（.clang-format）。我们将使用这个工具来统一代码风格。

1. 打开网址 [LLVM Snapshot Builds](http://llvm.org/builds/)，点击页面最后一个链接，下载 ClangFormat-r298093.vsix
1. 点击下载好的文件，直接安装。安装好之后应该能在 VS > Tools 菜单内见到相应按钮。

// TODO 待商讨代码风格 Google/Mozilla/LLVM？

规定代码风格的文件 `.clang-format` 届时会直接放在代码库里。

## 3. 克隆远程仓库到本地

一般来说，用 `git clone` 命令就可以了。但 cocos2d-x 项目较为复杂，牵涉较多，我们又要做跨平台。所以统一使用 `1.环境搭建与技术学习/make-local-*-repo.sh` 这个脚本来建立本地仓库。

将 `make-local-*-repo.sh` 拷贝到你想存放本地仓库的地方，然后运行这个 sh 脚本文件即可。如果你想知道它实际做了做了什么，可以使用 VS Code 打开以查看脚本内容。

## 4. 在本地 commit 并 push

### 4.1. commit/push 前注意

1. 确保编译通过
    代码能编译通过是 commit **最基本**的要求。因为一旦你 push commit，所有人都将能够获取到你的代码。如果你 push 的代码编译不通过，pull 下来之后，所有人的代码都会编译不通过，这会破坏所有人的开发体验。
1. 格式化你的代码
    代码风格统一是小组协作的首要条件。修改过某 c/c++ 源码之后，可以在 VS 内使用 Tools > 2 Clang Format Document，将整个文件格式化。

1. 使用 `$ git status` 和 `$ git diff` 查看引入的变化，确保没有引入不必要的修改
    比如你随手在某文件某处打的一个空格，这个时候 Git 会将其标记为已修改文件。这样当别人以 `--name-only` 查看你的 commit 都修改哪些文件时，会感到困惑。

    如果真的不小心引入了不必要的修改，可以按照『廖雪峰的 Git 教程』或者其他文档所讲解还原尚未 commit 的更改。

### 4.2. （选项一）使用 Git bash 来 commit

// TODO

### 4.3. （选项二）使用 Visual Studio 来 commit

// TODO by 张晨

### 4.4. commit msg 书写规范

WIP
seg fault

### 4.5. push 到 github(origin)

## 5. 管理 commit

// TODO or WON'T
