# Git 协作指南 | 开发工作流

本文描述使用 Git 进行小组内文档、代码协作的工作流，以及在工作流中需要遵守的各项规范。但并不提及 Git 的使用原理，在提及 Git 相关命令时也不再对其进行详细介绍。在阅读本文档前，请确保你已经阅读过 [廖雪峰的 Git 教程](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)。

---

<!-- TOC depthFrom:2 -->

- [1. 搭建本地协作环境](#1-搭建本地协作环境)
    - [1.1. 注册 GitHub 帐号](#11-注册-github-帐号)
    - [1.2. 安装和配置本地 Git 客户端](#12-安装和配置本地-git-客户端)
    - [1.3. 安装 clang-format](#13-安装-clang-format)
- [2. 都有哪些东西放入 Github 仓库](#2-都有哪些东西放入-github-仓库)
    - [2.1. 关于构建系统配置文件](#21-关于构建系统配置文件)
        - [2.1.1. /proj.win32/sln,vcxproj for Windows+VS](#211-projwin32slnvcxproj-for-windowsvs)
        - [2.1.2. /CMakeLists.txt for Linux](#212-cmakeliststxt-for-linux)
        - [2.1.3. /proj.android/jni/Android.mk for Android](#213-projandroidjniandroidmk-for-android)
    - [2.2. 关于 Resources](#22-关于-resources)
- [3. 仓库中都有哪些分支](#3-仓库中都有哪些分支)
    - [3.1. 日常开发 master --- 单分支、减少 Git 的使用负担](#31-日常开发-master-----单分支减少-git-的使用负担)
    - [3.2. Bug 联调、特性测试 --- 另开分支、做好隔离](#32-bug-联调特性测试-----另开分支做好隔离)
- [4. 克隆仓库到本地](#4-克隆仓库到本地)
- [5. 在本地工作](#5-在本地工作)
- [6. commit 并 push 到 Github 上](#6-commit-并-push-到-github-上)
    - [6.1. commit/push 前注意](#61-commitpush-前注意)
    - [6.2. commit msg 书写规范](#62-commit-msg-书写规范)
    - [6.3. commit/push 方式](#63-commitpush-方式)
- [7. 如果你遇到问题](#7-如果你遇到问题)

<!-- /TOC -->

---

本次『工程设计与管理』中，我们使用 Git 来进行小组内文档和代码协作，使用 clang-format 来统一代码风格。

## 1. 搭建本地协作环境

### 1.1. 注册 GitHub 帐号

1. 在 [GitHub](www.github.com) 上注册帐号，注意：

    使用英文 username。如果没有，现在选择一个。

1. 在注册完成并验证邮箱后，完善 GitHub 个人资料。

    在 Settings > Profile > Public profile 下填写 Name 一项后点击 `Update profie` 。开发过程中不要再更改此 Name。

### 1.2. 安装和配置本地 Git 客户端

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

### 1.3. 安装 clang-format

大括号换行的和大括号不换行的打起来怎么办？ (´_ゝ｀)

为了避免上面这种情况，我们使用统一的代码风格。[clang-format](https://clang.llvm.org/docs/ClangFormat.html) 可以跨平台使用，可以集成到各种 IDE 里面，而且使用纯文本形式的代码风格描述方式（.clang-format，这个文件届时会直接放入代码库）。我们将使用这个工具来统一代码风格。

1. 打开网址 [LLVM Download Page](http://releases.llvm.org/download.html)，下载 Clang for Windows (64-bit)
1. 安装时选择 `Add LLVM to the system PATH for all users`
1. 打开 Git Bash，输入 `clang-format.exe -i the-file-to-format` 即可对 the-file-to-format 进行格式化

## 2. 都有哪些东西放入 Github 仓库

简单的来说，cocos2d-x 能自动生成而且不需要人工干预或者更改的都不放入 Git 仓库。

具体哪些文件放入版本控制系统，参见代码库下 .gitignore 文件。

### 2.1. 关于构建系统配置文件

#### 2.1.1. /proj.win32/sln,vcxproj for Windows+VS

1. **VS 以 sln 和 proj 组成两级的构建系统**

    以我们的游戏项目为例：整个游戏项目是一个 sln，整个 sln 从源码到可运行程序的构建过程不仅仅需要我们自己写的代码，还需要 cocos2d-x 提供的代码，两套代码使用不同编译方案（编译时参数不同），所以 VS 提供了 proj 的概念。touhou-game 使用自己的 touhou-game.vcxproj 文件来控制自己的编译过程；libcocos2d 使用自己的 libbox2d.vcxproj 来控制自己的编译过程。

    两级构建系统示例：

    ```
    sln: touhou-game.sln
    |-- touhou-game.vcxproj
    |-- libcocos2d.vcxproj
    |-- libbox2d.vcxproj
    |-- ...
    `-- librecast.vcxproj
    ```

    `cocos new` 命令生成的项目下有一个文件夹 proj.win32，这个文件夹存放了 sln 及其游戏本身的 vcxproj。里面还有一些其他 windows-specific 的东西，不在本节讨论范围内。我们关注游戏 proj 的构建过程，只关注 /proj.win32/touhou-game.vcxproj

1. **但是 proj.win32 却不能直接放入版本管理**

    vcxproj 文件内容依赖于 VS 版本。vs2015 和 vs2017 遇到与自己构建系统版本不同的 vcxproj 时会进行 `重定向`，这导致了不同 vs 都会修改 touhou-game.vcxproj 文件。直接纳入版本管理直接导致混乱和冲突。

1. **故使用 proj.win32.github/proj.win32 双目录机制**

    因此，我们额外添加一个 proj.win32.github 目录。proj.win32.github 纳入版本管理，proj.win32 不纳入版本管理。使用时将 proj.win32.github 拷贝一份为 proj.win32。打开 proj.win32 中的 sln，进行 `重定向` 即可打开项目。

1. **顺便提一下 VS 的 filter**

    VS 构建用的就是上面所说的 sln/vcxproj。cxproj 写好就能正确构建项目。但是要想在 VS 的『Solution Explorer/解决方案浏览器』里显示源文件还需要显式指定 filter。

    > VS 并不按照文件系统中的文件结构在『Solution Explorer/解决方案浏览器』中显示源文件，它只根据 vcxproj.filters 里的描述来显示源文件

    `<Filter>` 在 vcxproj.filters 中定义（可以没有 `<UniqueIndentifier>`），定义 `<Filter>` 之后再在下面定义每个 `<ClCompile>` 或 `<ClInclude>` 项所属的 filter。全部定义好之后 VS 就可以在『Solution Explorer/解决方案浏览器』里面正确显示文件了。一个 filter 在『Solution Explorer/解决方案浏览器』里面表现为一个文件夹。一个 `<ClCompile>` 或 `<ClInclude>` 项在『Solution Explorer/解决方案浏览器』里面表现为一个文件。

1. **说了那么多，实际要怎么做**

    1. 构建项目 -- 编译不了就拷贝

        1. 开始时，将 proj.win32.github 拷贝一份为 proj.win32，打开 proj.win32 进行编译
        1. 若在和 GitHub 仓库同步后不能编译项目，关闭 VS，将 proj.win32.github 拷贝一份为 proj.win32，打开 proj.win32 重新编译
        1. 若无论如何都不能正常编译，及时与大家商讨

        *注意：任何人无特殊目的不得直接重命名 proj.win32.github 为 proj.win32，或直接打开 proj.win32.github 内的项目。这会扰乱 proj.win32.github 的正常版本管理*。

    1. 如何添加文件/目录 -- 手动

        为了保持 vxcproj 文件结构清晰，/proj.win32.github/touhou-game.vcxproj /proj.win32.github/touhou-game.vcxproj.filters 文件内容**手动维护**，禁止使用 VS 相应功能间接修改。

        1. 若是 .cpp 文件，添加 `<ClCompile>` 项到 /proj.win32.github/touhou-game.vcxproj 合适位置，并添加 `<ClCompile>` 项到 /proj.win32.github/touhou-game.vcxproj.filters 合适位置。（具体位置找见文件内注释）。
        1. 若是 .h 文件，添加 `<ClInclude>` 项到 /proj.win32.github/touhou-game.vcxproj 合适位置，并添加 `<ClInclude>` 项到 /proj.win32.github/touhou-game.vcxproj.filters 合适位置。（具体位置找见文件内注释）。
        1. 若是目录，则添加 `<Filter>` 项到 /proj.win32.github/touhou-game.vcxproj.filters 合适位置。`<Filter>` 项可以没有 `<Uniqueindentifier>`。

#### 2.1.2. /CMakeLists.txt for Linux

CMakelists.txt 是 CMake 编译项目必需的配置文件，主要由 Linux 平台使用。为控制构建 CMake 过程，需要手动修改其中内容。项目组中仅一人使用，由其个人维护和使用，此处不再额外说明。

#### 2.1.3. /proj.android/jni/Android.mk for Android

/proj.android/jni/Android.mk 是 Android NDK 构建系统的构建脚本。为正确构建 Android APK 需要手动修改其中内容。

// TODO 更详细的介绍

### 2.2. 关于 Resources

Resources 文件夹内放置实际在项目中使用资源。供挑选而未实际使用的资源定期上传至群文件里，不放置此处。

## 3. 仓库中都有哪些分支

![](../images/git-branchs-overview.jpg)

### 3.1. 日常开发 master --- 单分支、减少 Git 的使用负担

平常，我们工作在 master 分支上，也只需关心这个分支上的变化。平常的功能点，小的 bug 修复都直接做在这个分支上。

这个分支上汇聚着所有人的工作成果，合适的时候由组长在上面打 tag 来标识一个阶段的完成。

往上面推 commit 的原则是：别人将你推上去的 commit pull 下来之后不能影响他自己的工作，推上去之后没有特殊情况禁止撤销。

### 3.2. Bug 联调、特性测试 --- 另开分支、做好隔离

除了 master 分支做主开发之外，还有两种不常用而且较复杂的分支。如果你看不懂如下的说明，也不必担心，当真正使用这种分支的时候一般会由组长统筹。

1. **严重错误/联合调试**：要是你的代码一运行或者还没运行就 seg fault 了，而且它还处于游戏运行必经的路径上，那肯定是不能推到 master 分支上的，不然大家的本地代码都要玩完。

    如果另外一个人决定来帮你调试，但前提是你将其推到 Git 仓库里面（用别人的开发环境是来调试是一件痛苦的工作），那你必须将其推到一个新分支上，使其和 master 分支隔离。等到你们调试之后，再将其合并到 master 分支上。

    这种分支需要有人对 Git 有较深的了解才能正常创建和合并，所以当确实需要联调的时候尽量找组长。

1. **大型特性**：有些特性短时间不能做完，而且没做完的时候又不能推到 master 分支上，不然别人拉下来会破坏他自己的开发。

    这个时候需要将未完成的内容推到新特性分支上。不断往特性分支上推 commit，等到特性完成完成再合并到 master 分支上。

## 4. 克隆仓库到本地

一般来说，用 `git clone` 命令就可以了。但 cocos2d-x 项目较为复杂，牵涉较多，我们又要做跨平台。所以统一使用 `1.环境搭建与技术学习/make-local-*-repo.sh` 这个脚本来建立本地仓库。

将 `make-local-*-repo.sh` 拷贝到你想存放本地仓库的地方，然后运行这个 sh 脚本文件即可。如果你想知道它实际做了做了什么，可以使用 VS Code 打开以查看脚本内容。

## 5. 在本地工作

正式开工时，由组长讲解。

## 6. commit 并 push 到 Github 上

### 6.1. commit/push 前注意

1. 确保编译通过
    代码能编译通过是 commit **最基本**的要求。因为一旦你 push commit，所有人都将能够获取到你的代码。如果你 push 的代码编译不通过，pull 下来之后，所有人的代码都会编译不通过，这会破坏所有人的开发体验。

1. 格式化你的代码
    代码风格统一是小组协作的首要条件。修改过某 c/c++ 源码之后，可以在 VS 内使用 Tools > 2 Clang Format Document，将整个文件格式化。

1. 使用 `$ git status` 和 `$ git diff` 查看引入的变化，确保没有引入不必要的修改
    比如你随手在某文件某处打的一个空格，这个时候 Git 会将其标记为已修改文件。这样当别人以 `--name-only` 查看你的 commit 都修改哪些文件时，会感到困惑。

    如果真的不小心引入了不必要的修改，可以按照『廖雪峰的 Git 教程』或者其他文档所讲解还原尚未 commit 的更改。

### 6.2. commit msg 书写规范

一个书写良好的 commit msg 对理解一个 commit 干了哪些事情至关重要。

本着不重复造轮子的原则，我们这次的项目直接使用 [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/) 所描述的 "the seven rules"。但并不要求一定要写 commit body。

除 "the seven rules" 以外，本次项目设计中附加一条规则：

1. subject line 以 新增/修改 的模块名开头，并加一个冒号。
    以 Linux commit log 为例：

    `tcp: minimize false-positives on TCP/GRO check` 以模块名 tcp 开头

    `l2tp: take reference on sessions being dumped` 以模块名 l2tp 开头

    `drm/msm: Make sure to detach the MMU during GPU cleanup` 以模块名 drm/msm 开头

### 6.3. commit/push 方式

commit/push 有两种方式，a) Git Bash  b) Visual Studio 集成的 git 功能。可以选择你喜欢的方式，只要保证符合以上所述规范。

## 7. 如果你遇到问题

如果你上网查找了资料仍无法解决问题，及时找组长帮助。
