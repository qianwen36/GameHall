<GameProjectFile>
  <PropertyGroup Type="Node" Name="node_roomtips" ID="a658eb14-256f-45b7-bf55-a352838406f4" Version="2.3.0.1" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="23" Speed="0.4000" ActivedAnimationName="Ani_Appear">
        <Timeline ActionTag="-1096546538" Property="Position">
          <PointFrame FrameIndex="0" Tween="False" X="0.0000" Y="0.0000" />
          <PointFrame FrameIndex="1" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="11" Tween="False" X="0.0000" Y="0.0000" />
          <PointFrame FrameIndex="13" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="23" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="-1096546538" Property="Scale">
          <ScaleFrame FrameIndex="0" Tween="False" X="1.0000" Y="1.0000" />
          <ScaleFrame FrameIndex="1" X="0.1000" Y="0.1000">
            <EasingData Type="27" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="11" Tween="False" X="1.0000" Y="1.0000" />
          <ScaleFrame FrameIndex="13" X="1.0000" Y="1.0000">
            <EasingData Type="27" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="23" X="0.1000" Y="0.1000">
            <EasingData Type="27" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="-1096546538" Property="RotationSkew">
          <ScaleFrame FrameIndex="0" Tween="False" X="0.0000" Y="0.0000" />
          <ScaleFrame FrameIndex="1" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="11" Tween="False" X="0.0000" Y="0.0000" />
          <ScaleFrame FrameIndex="13" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="23" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="-1096546538" Property="Alpha">
          <IntFrame FrameIndex="1" Value="0">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="11" Tween="False" Value="255" />
          <IntFrame FrameIndex="13" Value="255">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="23" Value="0">
            <EasingData Type="0" />
          </IntFrame>
        </Timeline>
        <Timeline ActionTag="-1096546538" Property="FrameEvent">
          <EventFrame FrameIndex="11" Tween="False" Value="Play_Over" />
          <EventFrame FrameIndex="23" Tween="False" Value="Play_Over" />
        </Timeline>
      </Animation>
      <AnimationList>
        <AnimationInfo Name="Ani_Appear" StartIndex="1" EndIndex="12">
          <RenderColor A="255" R="218" G="112" B="214" />
        </AnimationInfo>
        <AnimationInfo Name="Ani_Disappear" StartIndex="13" EndIndex="24">
          <RenderColor A="255" R="112" G="128" B="144" />
        </AnimationInfo>
      </AnimationList>
      <ObjectData Name="Node" Tag="250" ctype="GameNodeObjectData">
        <Size />
        <Children>
          <AbstractNodeData Name="Panel_Shade" ActionTag="-140167067" Tag="278" IconVisible="False" LeftMargin="-640.0000" RightMargin="-640.0000" TopMargin="-640.0000" BottomMargin="-640.0000" TouchEnable="True" BackColorAlpha="178" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="1280.0000" Y="1280.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize X="1.0000" Y="1.7778" />
            <SingleColor A="255" R="0" G="0" B="0" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Img_MainBG" ActionTag="-1096546538" Tag="279" Alpha="0" IconVisible="False" LeftMargin="-382.5000" RightMargin="-382.5000" TopMargin="-132.0000" BottomMargin="-132.0000" Scale9Enable="True" LeftEage="74" RightEage="74" TopEage="60" BottomEage="60" Scale9OriginX="74" Scale9OriginY="60" Scale9Width="77" Scale9Height="64" ctype="ImageViewObjectData">
            <Size X="765.0000" Y="264.0000" />
            <Children>
              <AbstractNodeData Name="Text_Test" ActionTag="-1970619140" Tag="280" IconVisible="False" LeftMargin="267.9647" RightMargin="273.0353" TopMargin="85.3825" BottomMargin="150.6175" FontSize="28" LabelText="先去包房玩一盘吧" HorizontalAlignmentType="HT_Center" VerticalAlignmentType="VT_Center" OutlineSize="0" ShadowOffsetX="0" ShadowOffsetY="0" ctype="TextObjectData">
                <Size X="224.0000" Y="28.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="379.9647" Y="164.6175" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4967" Y="0.6236" />
                <PreSize />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_Enter" ActionTag="-1746980630" Tag="281" IconVisible="False" HorizontalEdge="BothEdge" VerticalEdge="BothEdge" LeftMargin="270.4755" RightMargin="275.5245" TopMargin="163.3048" BottomMargin="21.6952" TouchEnable="True" FontSize="32" ButtonText="进入包房" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="189" Scale9Height="57" OutlineSize="0" ShadowOffsetX="0" ShadowOffsetY="0" ctype="ButtonObjectData">
                <Size X="219.0000" Y="79.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="379.9755" Y="61.1952" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4967" Y="0.2318" />
                <PreSize X="0.2863" Y="0.2992" />
                <TextColor A="255" R="255" G="255" B="255" />
                <PressedFileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/CommonBtn/Hall_CommonBtn_Green.png" Plist="hallcocosstudio/images/plist/CommonBtn.plist" />
                <NormalFileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/CommonBtn/Hall_CommonBtn_Green.png" Plist="hallcocosstudio/images/plist/CommonBtn.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_Exit" ActionTag="-1787327301" Tag="282" IconVisible="False" HorizontalEdge="BothEdge" VerticalEdge="BothEdge" LeftMargin="693.6760" RightMargin="-7.6760" TopMargin="-9.0392" BottomMargin="197.0392" TouchEnable="True" FontSize="14" Scale9Enable="True" Scale9Width="79" Scale9Height="76" OutlineSize="0" ShadowOffsetX="0" ShadowOffsetY="0" ctype="ButtonObjectData">
                <Size X="79.0000" Y="76.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="733.1760" Y="235.0392" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.9584" Y="0.8903" />
                <PreSize X="0.1033" Y="0.2879" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                <PressedFileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/Common/Hall_Btn_Close.png" Plist="hallcocosstudio/images/plist/Common.plist" />
                <NormalFileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/Common/Hall_Btn_Close.png" Plist="hallcocosstudio/images/plist/Common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="0.1000" ScaleY="0.1000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="Normal" Path="hallcocosstudio/images/png/charteredroom/Friend_Box_Tips.png" Plist="" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameProjectFile>