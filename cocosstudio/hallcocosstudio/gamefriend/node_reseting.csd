<GameProjectFile>
  <PropertyGroup Type="Node" Name="node_reseting" ID="96fa899e-fe22-4954-8f21-de9aa5724e26" Version="2.3.0.1" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="60" Speed="0.6667">
        <Timeline ActionTag="830833275" Property="Position">
          <PointFrame FrameIndex="1" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="20" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="40" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="60" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="830833275" Property="Scale">
          <ScaleFrame FrameIndex="1" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="20" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="40" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="60" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="830833275" Property="RotationSkew">
          <ScaleFrame FrameIndex="1" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="20" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="40" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="60" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="830833275" Property="Alpha">
          <IntFrame FrameIndex="1" Value="255">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="40" Value="76">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="60" Value="255">
            <EasingData Type="0" />
          </IntFrame>
        </Timeline>
        <Timeline ActionTag="2041203259" Property="Position">
          <PointFrame FrameIndex="1" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="60" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="2041203259" Property="Scale">
          <ScaleFrame FrameIndex="1" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="60" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="2041203259" Property="RotationSkew">
          <ScaleFrame FrameIndex="1" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="60" X="360.0000" Y="360.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
      </Animation>
      <AnimationList>
        <AnimationInfo Name="Ani_Reseting" StartIndex="1" EndIndex="60">
          <RenderColor A="255" R="255" G="239" B="213" />
        </AnimationInfo>
      </AnimationList>
      <ObjectData Name="Node" Tag="17" ctype="GameNodeObjectData">
        <Size />
        <Children>
          <AbstractNodeData Name="Img_BG" ActionTag="2017845822" Tag="18" IconVisible="False" LeftMargin="-60.0000" RightMargin="-60.0000" TopMargin="-60.0000" BottomMargin="-60.0000" Scale9Width="120" Scale9Height="120" ctype="ImageViewObjectData">
            <Size X="120.0000" Y="120.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="Normal" Path="hallcocosstudio/images/png/charteredroom/Friend_LoadingBG.png" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="Img_TextReset" ActionTag="830833275" Tag="20" Alpha="111" IconVisible="False" LeftMargin="-58.0000" RightMargin="-58.0000" TopMargin="-22.5000" BottomMargin="-22.5000" Scale9Width="116" Scale9Height="45" ctype="ImageViewObjectData">
            <Size X="116.0000" Y="45.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="Normal" Path="hallcocosstudio/images/png/charteredroom/Friend_TextReseting.png" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="Img_Light" ActionTag="2041203259" Tag="21" Rotation="262.3729" RotationSkewX="262.3729" RotationSkewY="262.3729" IconVisible="False" LeftMargin="-77.5000" RightMargin="-77.5000" TopMargin="-77.5000" BottomMargin="-77.5000" Scale9Width="155" Scale9Height="155" ctype="ImageViewObjectData">
            <Size X="155.0000" Y="155.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="Normal" Path="hallcocosstudio/images/png/Hall_Loading.png" Plist="" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameProjectFile>