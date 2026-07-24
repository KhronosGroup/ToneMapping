# 色调映射器

<p align="center"><a href="./README.md">English</a> · <a href="./README.zh-CN.md">简体中文</a> · <a href="./README.ja.md">日本語</a></p>

一组用于显示 3D 图形的色调映射器，具体用于将来自 PBR 的 HDR 线性光（其范围比最好的 HDR 电视大多个数量级）转换为 SDR 或其他显示设备的输出范围。

## [PBR Neutral](PBR_Neutral)
一款专为确保 PBR 色彩准确性而设计的色调映射器，使输出渲染中的 sRGB 色彩在灰度照明下尽可能忠实地匹配输入的 sRGB baseColor。它面向产品摄影用例：场景曝光良好，HDR 色彩值大多仅限于较小的镜面高光区域。
