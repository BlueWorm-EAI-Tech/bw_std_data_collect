# Runtime 配置（采集）

采集只用**一份机位 YAML** + 命令行覆盖。没有 cell / profile / site 叠层。

## 文件

| 路径 | 写什么 |
| --- | --- |
| `config/robot.yaml` | 默认机位（可复制改名） |
| `config/szw-bot1.yaml` | 208 现场示例 |
| `config/legacy-4cam-cwjud7hu.yaml` | 四相机示例 |

YAML 四段：`ros` / `robot` / `cameras` / `dataset`。每个相机只在 `cameras.streams` 写一套分辨率与 topic；**不要** `cameras.modes`。

## 启动

```bash
./bin/mantis-data collect --config config/szw-bot1.yaml
./bin/mantis-data collect --config config/szw-bot1.yaml --enable-chassis
./bin/mantis-data collect --config config/szw-bot1.yaml --state-only
```

底盘默认看 YAML 里的 `robot.enable_chassis`；`--enable-chassis` / `--disable-chassis` 覆盖。

## CLI 可覆盖

- `--dataset.root`、`--robot.namespace`、`--task`
- `--enable-chassis` / `--disable-chassis`
- 相机工具：`--camera-width` / `--camera-height` / `--camera-fps` / `--camera-transport`

## 数据集

一次 `collect` = **一个** LeRobot **v3.0** 目录，进程内多集（`i` 开始 / `o` 保存 / `d` 丢缓冲 / `q` finalize）。  
禁止一集一个目录。`--resume-dataset` 只接受已有 v3.0。
