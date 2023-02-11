```yaml
# A simple YAML example

# scalar values can be expressed as string, integer, or float
string_value: Hello, World!
integer_value: 42
float_value: 3.14159

# lists can be expressed as sequences of items
list_value:
  - item 1
  - item 2
  - item 3

# mappings can be expressed as key-value pairs
mapping_value:
  key 1: value 1
  key 2: value 2
  Key 3: value 3

# you can use inline styles to make the output more compact
inline_mapping: {key 1: value 1, key 2: value 2}

# A list of object
Person:
  - name: John Doe
    age: 32
    city: New York
  
  - name: Jane Doe
    city: Los Angeles
  
  - name: Bob Smith
    age: 44
    city: Chicago


# you can use quotes to preserve special characters
quoted_value: "Hello, World!"

# you can use multi-line strings for more complex values
multiline_value: |
  This is a
  multi-line
  string value.

# you can also include null, boolean, and date values
null_value: null
boolean_value: true
date_value: 2022-12-31

# 使用环境变量
web:
  image: "webapp:${TAG}"


# 在 YAML 中，三个连续的破折号（---）被称为文档起始标记，用于标识一个独立的 YAML 文档。如果 YAML 文件包含多个文档，则每个文档都必须以三个连续的破折号开头。
---
# YAML 配置文件

# 定义锚点
address: &address
  street: 123 Main St.
  city: San Francisco
  state: CA
  zip: 94111

# 使用锚点 (锚点不能跨文档使用)
john:
  name: John Doe
  age: 30
  address: *address

jane:
  name: Jane Doe
  age: 25
  address: *address

```

## 基本语法

- 大小写敏感
- 使用缩进表示层级关系
- 在 YAML 中，缩进与语法结构相关，因此使用空格而不是 tab 字符来表示缩进是标准做法
- 缩进的空格数不重要，只要相同层级的元素左对齐即可
- '#'表示注释

## 数据类型

- 对象：键值对的集合，又称为映射（mapping）/ 哈希（hashes） / 字典（dictionary）
- 数组：一组按次序排列的值，又称为序列（sequence） / 列表（list）
- 纯量（scalars）：单个的、不可再分的值

## 使用环境变量

```yml
web:
  image: "webapp:${TAG}"
```

## YML 和 JSON 都是有类型的
> https://github.com/spring-projects/spring-boot/issues/9389

- hahaSystemId2 即使在 java config 类的字段类型是 `String`, 也会得到 `6` 而非 `06`, 因为 yml 这里已经有类型了，被当作数字对待，然后就变成 6 了

- 如果需要保留 0在前面，需要用引号引起来

```yml
something:
  systemId: 154
  hahaSystemId1: "06"
  hahaSystemId2: 06 
```
