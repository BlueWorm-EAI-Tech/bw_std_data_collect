# bw_std_data_collect

BlueWorm 标准数据采集客户端。仓库内只有 Nuitka 编译的 `.so`、薄 shell 入口与示例配置，不包含 lerobot / ROS 2。

当前版本见 `VERSION`（`0.2.0-closed`）。

## 仓库结构

```
bin/mantis-data              # 主入口
*.so                         # 编译后的采集与工具逻辑（Linux x86_64 / CPython 3.10）
config/                      # 机位 YAML 示例
scripts/                     # 相机 / 检查等薄包装脚本
docs/CONFIG.md               # 配置说明
releases/                    # 同版本 tar.gz / .run 安装包
REQUIREMENTS.host.txt        # 宿主机需自备的依赖
```

## 适用环境

| 项 | 要求 |
| --- | --- |
| 系统 | Ubuntu 22.04，x86_64 |
| Python | **3.10**（ABI：`cpython-310-x86_64-linux-gnu`） |
| 中间件 | ROS 2 Humble + `rclpy` |
| 数据格式 | `lerobot>=0.4.4,<0.5`（LeRobot **v3.0**） |
| 其它 | numpy、opencv-python、pyyaml；现场 BlueWorm / 机器人 ROS 接口 |

本仓库**不**安装上述依赖，请在机器人主机上自行准备。

## 快速开始

```bash
git clone https://github.com/BlueWorm-EAI-Tech/bw_std_data_collect.git
cd bw_std_data_collect

cp config/robot.yaml config/my-robot.yaml
# 编辑 my-robot.yaml：namespace、相机串号、数据集目录等

./bin/mantis-data doctor
./bin/mantis-data collect --config config/my-robot.yaml --state-only --task "Pick and place the cube."
```

采集按键：

| 键 | 作用 |
| --- | --- |
| `i` | 开始一集 |
| `o` | 写入当前集到数据集 |
| `d` | 丢弃当前缓冲 |
| `q` | 结束并 `finalize()` |

一次 `collect` = **一个** LeRobot v3.0 目录，进程内多集；不要一集一个目录。

## 常用命令

```bash
./bin/mantis-data doctor
./bin/mantis-data preflight --state-only
./bin/mantis-data cameras start|stop|check
./bin/mantis-data collect --config config/szw-bot1.yaml --state-only --task "..."
./bin/mantis-data collect --config config/my-robot.yaml --enable-chassis
./bin/mantis-data dataset /path/to/dataset --expect-state-only --for-training
```

也可用 `scripts/*.sh` 包装脚本（内部仍调用 `bin/mantis-data` 或编译模块）。

## 用安装包部署（可选）

若不方便 clone，可用 `releases/` 里的自解压包：

```bash
./releases/mantis-data-collector-0.2.0-closed-linux-x86_64.run --target "$HOME/mantis-data-collector"
```

## 配置要点

- 只用**一份**机位 YAML（`ros` / `robot` / `cameras` / `dataset`），见 `docs/CONFIG.md`。
- 相机只在 `cameras.streams` 写分辨率与 topic，不要写 `cameras.modes`。
- 底盘默认看 YAML `robot.enable_chassis`；CLI `--enable-chassis` / `--disable-chassis` 可覆盖。
- 可选环境文件：复制 `config/mantis_data.env.example` → `config/mantis_data.env`（勿提交含密钥的 env）。

## 本仓库明确不包含

- 任何 `.py` 业务源码
- ACT / OpenPI 推理客户端与训练产物
- 现场密码、密钥、内网地址
- ROS 2 / LeRobot / 相机驱动本体

## 许可与分发

闭源交付物，仅限授权现场与内部使用；未经许可不得二次分发或逆向用于未授权用途。

维护：具身组
