China Stock Price Calculator
====================================
## Base Information ##
* Name
 + Chinese name 股价成本计算器
 + English name China Stock Price Calculator
* Project Name - CNStockCalculator


## Data ##

### organization ###
* record.db(sqlite3)
 + table record
  - trade(BOOL) YES=buy/NO=sell
  - date(datetime)
  - price(float)
  - count(unsigned long int)
* NSUserDefaults
<pre>
 {commission:$float$}
 {stamp:$float$}
 {transfer:$float$}
</pre>
 
### store ###

## view ##
* launch
* record
* calculator
* settings

### image resource ###
图标 icon
记录tabitem 图片
计算器图片
齿轮图片
Tabbar
 record 记录 
 calculator 计算 计算器图片
 settings 设置 齿轮图片


### lanch view ###
[image view 精打细算]
[image view iconx32]  [label codepongo.com]
### records view ###
| search bar | 
[买/卖]名称 买入价格 买入数量 盈亏比/保本价 >

### calculator view ###
投资损益（卖） | 保本卖出价（买）(segment bar)
股票代码/名称       text field
股票类型                picker
买入价格      text field 元/股
买入数量      text field 股
卖出价格      text field 元/股
卖出数量      text field 股
券商佣金比率  text field %
印花税税率    text field %
过户费费率               元/股
                  计算    重置  
计算结果
过户费
印花税
券商佣金
税费合计
投资损益
盈亏比例
/
保本卖出价
         保存  重置               
### layout ###
Main[TabBarView]
 Record[NavigationView]
  Records[TableView pain] - 可编辑 可查找 详细
  RecordDetail[TableView grouped]
 Calculator[TableView grouped]
 Settings[TableView grouped]

## Reference ##
http://finance.sina.com.cn/calc/stock_protected.html

