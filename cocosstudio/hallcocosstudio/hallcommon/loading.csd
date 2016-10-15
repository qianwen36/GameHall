<GameProjectFile>
  <PropertyGroup Type="Layer" Name="loading" ID="5d3d4e5c-3378-4bd2-a592-56e360d35320" Version="2.3.0.1" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="60" Speed="1.0000">
        <Timeline ActionTag="1914362464" Property="RotationSkew">
          <ScaleFrame FrameIndex="0" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="60" X="360.0000" Y="360.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
      </Animation>
      <AnimationList>
        <AnimationInfo Name="Animation_Loading" StartIndex="0" EndIndex="60">
          <RenderColor A="255" R="205" G="133" B="63" />
        </AnimationInfo>
      </AnimationList>
      <ObjectData Name="loading" Tag="173" ctype="GameLayerObjectData">
        <Size X="1280.0000" Y="720.0000" />
        <Children>
          <AbstractNodeData Name="Panel_Shade" ActionTag="-561857454" Tag="1152" IconVisible="False" HorizontalEdge="BothEdge" VerticalEdge="BothEdge" TopMargin="-280.0000" BottomMargin="-280.0000" TouchEnable="True" BackColorAlpha="127" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="1280.0000" Y="1280.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="640.0000" Y="360.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="1.0000" Y="1.7778" />
            <SingleColor A="255" R="0" G="0" B="0" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Panel_LoadingCircle" ActionTag="1856903784" Tag="1044" IconVisible="False" HorizontalEdge="BothEdge" VerticalEdge="BothEdge" LeftMargin="540.0000" RightMargin="540.0000" TopMargin="260.0000" BottomMargin="260.0000" TouchEnable="True" BackColorAlpha="102" ColorAngle="90.0000" ctype="PanelObjectData">
            <Size X="200.0000" Y="200.0000" />
            <Children>
              <AbstractNodeData Name="Img_loading" ActionTag="1914362464" Tag="176" Rotation="324.0000" RotationSkewX="324.0000" RotationSkewY="324.0000" IconVisible="False" LeftMargin="22.5000" RightMargin="22.5000" TopMargin="22.5000" BottomMargin="22.5000" ctype="SpriteObjectData">
                <Size X="155.0000" Y="155.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="100.0000" Y="100.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.5000" />
                <PreSize />
                <FileData Type="Normal" Path="hallcocosstudio/images/png/Hall_Loading.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="640.0000" Y="360.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameProjectFile>