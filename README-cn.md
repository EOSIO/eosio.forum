一个简易的EOS论坛，有通信和投票系统
===================================================

该论坛不会在区块链RAM中存储任何东西。 它允许通过身份验证的消息的发布，这样你在链的历史记录中可以看到它。 
它需要链外工具来对各种受Forum合约支持的呼叫的输出进行排序，显示，汇总和报告。


Actions
=======

这个合约中有这些供你用的action：
* `post` / `unpost` - 通过区块链po点什么，但它不会被存在链上
* `status` - po一行小博文（类似Twitter），它会被存储在链上以便快速检索
* `propose` / `unpropose` - 在链上存一个提案，人们可以来给它投票
  * `vote` - 跟 `propose` 一起用的, 给提案投票

参阅以上action的参数 [abi/forum.abi](ABI 文档)。


使用示例
----------

`post`:

```
cleos push action eosforumdapp post '{"poster": "YOURACCOUNT", "post_uuid":"somerandomstring", "content": "hello world", "reply_to_poster": "", "reply_to_post_uuid": "", "certify": false, "json_metadata": "{\"type\": \"chat\"}"}' -p YOURACCOUNT@active
```


`propose`:

```
cleos push action eosforumdapp propose '{"proposer": "proposeracct", "proposal_name": "theproposal", "title": "The title, for list views", "proposal_json": "{\"type\": \"bps-proposal-v1\", \"content\":\"This is the contents of the proposition\"}"}' -p YOURACCOUNT@active

# Review with:

cleos get table eosforumdapp proposeracct proposal
```

`vote`:

```
cleos push action eosforumdapp vote '{"voter": "YOURACCOUNT", "proposer": "proposeracct", "proposal_name": "theproposal", "proposition_hash": "[sha256 of title + proposal_json]", "vote": true, "vote_json": ""}' -p YOURACCOUNT@active
```

`status`:

```
cleos push action eosforumdapp status '{"account": "YOURACCOUNT", "content": "This is my status line"}' -p YOURACCOUNT@active

# Review with:

cleos get table eosforumdapp eosforumdapp status
```



公投结构提案
==============================

用 `propose` 提一个可投票的问题，设置投票的选项参数 (`proposal_json` version #1)

```
proposer: eosio
proposal_name: thequestion
title: "EOSIO Referendum: The Question About ECAF and friends"  # An English string, to be shown in UIs
proposal_json: '{
  "type": "bps-proposal-v1",
  "content": "# Tally method\n\nThe tally method will be this and that, ... to the best of the active Block Producers's ability.\n\n# Voting period\n\nThe vote will stretch from the block it is submitted, and last for 1 million blocks.\n\n# Vote meaning\n\nA `vote` with value `true` means you adhere to the proposition.  A `vote` with value `false` means you do not adhere to the proposition.\n\n# The question\n\nDo you wish ECAF to become Santa Claus ?"
}'
```

`vote` 应该是长成这个样子的:

```
voter: myaccount
proposer: eosio
proposal_name: thequestion
proposal_hash: acbdef112387abcefe123817238716acbdef12378912739812739acbd  # sha256 of "title + proposal_json" of proposal
vote: true
vote_json: ''
```

proposal_hash存在意义是为了确保向用户呈现了正确的内容。 
UI会对显示的内容出一个hash，以减少他人用不同的内容替换其命题并在伪造收集在链上的投票的风险。

---

`proposal_json` 架构 #2:

```
proposal_json: '{
  "type": "bps-proposal-v2",
  "tally": "The tally method will be this and that, ... to the best of the active Block Producers's ability.",
  "voting_period": "The vote will stretch from the block it is submitted, and last for 1 million blocks.",
  "vote_meaning": "A `vote` with value `true` means you adhere to the proposition.  A `vote` with value `false` means you do not adhere to the proposition.",
  "question": "Do you wish ECAF to become Santa Claus ?"
}'
```

---

`proposal_json` 架构 #3:

```
proposal_json: '{
  "type": "bp-proposal-v3",
  "tally": "The tally method will be this and that, ... to the best of the active Block Producers's ability.",
  "voting_period": "The vote will stretch from the block it is submitted, and last for 1 million blocks.",
  "vote_meaning": "A `vote` with value `true` means you adhere to the proposition.  A `vote` with value `false` means you do not adhere to the proposition.",
  "question": {
    "en": "Do you wish ECAF becomes Santa Claus?",
    "fr": "Voulez-vous que l'ECAF devienne le père Noël ?"
  }
}'
```


JSON 架构词汇表
------------------------------

您可以在发布帖子，提案和投票时使用任何你想用的词汇。 但是，
通过遵循一些简单的规则，你可以轻松点儿，也让靠这些消息构建UI的人们轻松点儿。

对于 `propose`、 `vote` 和 `post` 中的所有 `json` 前缀或后缀字段，
类型字段决定更高阶的协议，也会决定将需要哪些其他同级类型字段。

### 在 `proposal` 的 `proposal_json` 字段中

* `type` 是区分协议的必填字段。 请参阅下面的types。

* `question` 是提案的参考语言问题。

* `content` 是Markdown文档，详细说明了有关提案的所有信息
（计数方法，时间范围，参考信息，要求等）。

* `ends_at_block_height` 是一个整数，表示上最后一个区块的高度（包含性的），
在该高度上将对该命题计算投票。 在此高度之后投的票都不会被计算在内。


### 在 `vote` 的 `vote_json` 字段中

* `type` 是可有可无的。 如果没有，则默认为 `simple`。

`proposal_hash` 不是由合约强制执行的，
但某些提案可能会需要它才会计票中的某个投票。

#### `type` 值

* `simple` 就跟没有任何 `type` 是一样的。 投票的值是 _action_ 的布尔 `vote` 字段。 


### 在 `post` 的 `json_metadata` 字段中

* `type` 是区分协议的必填字段。 请参阅下面的样本types。

以下字段尝试标准化某些键的含义。 如果你指定自己的 `type`，你则可以定义任何内容。

* `title` 是一个标题，将显示在消息上方，通常用于可点击的标题。 类似于Reddit帖子的标题。

* `tags` 是一个字符串列表，带前缀或不带 `＃`。


#### `type` 值

* `chat`，一个简单的对话，可以推出一个消息。

* `eos-bps-roll-call`，在 EOS Block Producers  调用中用于表示它们存在。

* `eos-bps-emergency`，一旦**3**个BP在一小时内发出这个消息，
所有的BP都可以在1小时内触发唤醒警报。 请勿滥用此消息以避免警报疲劳。 
一些警报的例子：严重漏洞需要缓解，严重的网络问题，需要立即采取行动等。

* `eos-bps-notify`，一旦 **7** 个BP在一小时内发出此类消息，其他BP可以在 
**接下来的24小时内** 触发通知以引起他们的注意。 比如：新的ECAF指令需要注意。


* `eos-arbitration-order`，BP们可以监视已知的仲裁论坛帐户，并提醒自己所需的操作。 
剩下的字段可以被定义为PDF格式顺序的链接; 对现成的 `eosio.msig` 交易提案的引用; 
等等……


当前推出
===============

最新版的代码放在了EOS主网的 `eosforumdapp` 账号上。

最初支持此合同的工具是：
* [eosc](https://github.com/eoscanada/eosc) 运用命令行界面的来提交帖子和投票。
* https://eostoolkit.io/forumpost 允许你通过合约来发布帖子。
* MyEOSKit 已经有 post 这个 action 的特殊外壳了。 
你可以[参阅这个交易](https://www.myeoskit.com/?#/tx/c40e30d70ee92a0f57af475a828917851aa62b01bfbf395efae5c1a2b22068f0)。




证书
=======

MIT


致谢
=======

原始代码和灵感来自于 Daniel Larimer
