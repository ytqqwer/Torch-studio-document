# Markdown 写作指南

为便于多人协作和追踪修改记录，推荐使用 Markdown 格式来书写文档。

<!-- TOC depthFrom:2 -->

- [1. Markdown 参考资料](#1-markdown-参考资料)
- [2. Markdown 编辑器](#2-markdown-编辑器)
- [3. 文档格式要求](#3-文档格式要求)
    - [3.1. 图片放入 images 目录](#31-图片放入-images-目录)
    - [3.2. 要实时生成和更新目录](#32-要实时生成和更新目录)
    - [3.3. 最多允许三级的文档层次](#33-最多允许三级的文档层次)
    - [3.4. 段落间用空行分隔、段落内不允许换行](#34-段落间用空行分隔段落内不允许换行)

<!-- /TOC -->

## 1. Markdown 参考资料

Markdown 是一种没有标准约束的语言，我们现在接触到的 Markdown 大多都与 SM（Standard Markdown）有轻微不同，属于 Markdown 变种。我们使用 GitHub Flavored Markdown（简称 GFM），它是 GitHub 对 SM 的轻微扩展，添加了表格和高亮代码块功能。

GitHub Help 中有关于 GFM 的介绍：

- [基本语法（Basic writing and formating syntax）](https://help.github.com/articles/basic-writing-and-formatting-syntax/)。
- [表格（Organizing information with tables）](https://help.github.com/articles/organizing-information-with-tables/)。
- [高亮代码块（Creating and highlighting code blocks）](https://help.github.com/articles/creating-and-highlighting-code-blocks/)。

GitHub Help 是英文的文档，阅读起来可能不太方便。如果实在不想看英文文档的话，可以使用这个中文应用作为 Markdown 语法学习和入门阶段练习的场地：[欢迎使用 Cmd Markdown 编辑阅读器](https://www.zybuluo.com/mdeditor)。但要注意，GFM 中并不具备 Cmd Markdown 中的 `LaTeX` `流程图` `序列图` `甘特图` 功能。这些都属于 Cmd Markdown 对 SM 的扩展，请勿在提交到 GitHub 上的 Markdown 文档中使用。

一般来说上面这些内容就足够了，如果想对 Markdown 有更深的了解，有以下文档可供参考（按次序由简入深）：

- [Official Introduction](http://daringfireball.net/projects/markdown/)。Markdown 语言的作者 John Gruber 对 Markdown 设计哲学以及语法的介绍。
- [Markdown 语法说明](http://wowubuntu.com/markdown/index.html)。对每个 Markdown 标记对应的 HTML 进行介绍。
- [讲解 Markdown](http://ju.outofmemory.cn/entry/149460)。不仅涵盖 Markdown 的语法，而且在一个比较全面（涉及方面比较多的）的角度上对 Markdown 的实现和各种扩展以及工具进行介绍。

## 2. Markdown 编辑器

要求使用 VS Code + 插件 Markdown TOC (by Alanwalk)。

## 3. 文档格式要求

### 3.1. 图片放入 images 目录

文档库根目录下有一 images 文件夹，专门用于放置所有在 Markdown 文档中引用的图片。.jpg/.png 图片要上传至此后，再以相对路径 `![Alt text](../images/path-to-image)` 的方式插入 Markdown 文件中。

### 3.2. 要实时生成和更新目录

为方便对文档进行预览，要求使用 VS Code 对大型文档自动生成和实时更新目录。使用 VS Code 生成和更新目录的步骤如下：

1. 安装 VS Code 插件 `Markdown TOC` by AlanWalk
1. 按照 `Markdown TOC` 自带文档所示生成目录，编号章节

生成或更新目录时要注意：

1. 不要手动添加章节编号，插件会自动生成
1. 目录要放在标题下面

初次生成目录时后：

1. 将所生成目录 `<!-- TOC -->` 一行改为 `<!-- TOC depthFrom:2 -->` ，然后再次生成目录和给章节编号
1. 删除文档首行多余的 `1. ` 编号

### 3.3. 最多允许三级的文档层次

文档中除使用 `#` 确定文档标题外，最多允许使用三级结构：`##` 作为章节，`###` 作为小节，`####` 作为小小节。并推荐使用有序列表，而不是 `######` 这样的多层次结构。如果你的文档中出现超过三级的结构，这普遍意味着结构混乱，请对文档结构进行重构。

### 3.4. 段落间用空行分隔、段落内不允许换行

1. 在一个段落内禁止换行。比较长的段落在 VS Code 中的显示问题可以使用自动 wrap 来解决：view --> Toggle Word Wrap
1. 两段落之间必须加一个（最多不能超过两个）空白行
1. 章节名与正文之间必须加一个且仅一个空白行
1. 列表与正文之间加一个空白行。无论是有序列表还是无序列表，列表与上一个文本块之间，下一个文本块之间要加一个空白行
