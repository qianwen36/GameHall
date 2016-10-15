<GameProjectFile>
  <PropertyGroup Type="Node" Name="node_tip" ID="2db4cc5b-ec14-4ba4-a944-44b4770b2c2a" Version="2.3.0.1" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="11" Speed="0.3333" ActivedAnimationName="animation_appear">
        <Timeline ActionTag="-1398886696" Property="Position">
          <PointFrame FrameIndex="1" X="0.0000" Y="117.0000">
            <EasingData Type="1" />
          </PointFrame>
          <PointFrame FrameIndex="5" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="7" X="0.0000" Y="0.0000">
            <EasingData Type="1" />
          </PointFrame>
          <PointFrame FrameIndex="11" X="0.0000" Y="117.0000">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="-1398886696" Property="Scale">
          <ScaleFrame FrameIndex="1" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="5" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="7" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="11" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="-1398886696" Property="RotationSkew">
          <ScaleFrame FrameIndex="1" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="5" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="7" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="11" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="-1398886696" Property="FrameEvent">
          <EventFrame FrameIndex="5" Tween="False" Value="Play_Over" />
          <EventFrame FrameIndex="11" Tween="False" Value="Play_Over" />
        </Timeline>
      </Animation>
      <AnimationList>
        <AnimationInfo Name="animation_appear" StartIndex="1" EndIndex="6">
          <RenderColor A="255" R="165" G="42" B="42" />
        </AnimationInfo>
        <AnimationInfo Name="animation_disappear" StartIndex="7" EndIndex="12">
          <RenderColor A="255" R="255" G="140" B="0" />
        </AnimationInfo>
      </AnimationList>
      <ObjectData Name="Node" Tag="167" ctype="GameNodeObjectData">
        <Size />
        <Children>
          <AbstractNodeData Name="Panel_Tip_Animation" ActionTag="-1398886696" Tag="163" IconVisible="False" LeftMargin="-360.0000" RightMargin="-360.0000" TopMargin="-117.0000" TouchEnable="True" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="720.0000" Y="117.0000" />
            <Children>
              <AbstractNodeData Name="Img_MainBG" ActionTag="1727270127" Tag="169" IconVisible="False" LeftMargin="1.3240" RightMargin="1.6760" TopMargin="-1.3240" BottomMargin="1.3240" Scale9Width="717" Scale9Height="117" ctype="ImageViewObjectData">
                <Size X="717.0000" Y="117.0000" />
                <AnchorPoint />
                <Position X="1.3240" Y="1.3240" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.0018" Y="0.0113" />
                <PreSize X="0.9958" Y="1.0000" />
                <FileData Type="Normal" Path="hallcocosstudio/images/png/charteredroom/Game_TipsBG.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Text_Detail" ActionTag="-814548594" Tag="252" IconVisible="False" LeftMargin="258.6482" RightMargin="221.3518" TopMargin="12.0132" BottomMargin="80.9868" FontSize="24" LabelText="%s邀请您去包房玩游戏" OutlineSize="0" ShadowOffsetX="0" ShadowOffsetY="0" ctype="TextObjectData">
                <Size X="240.0000" Y="24.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="378.6482" Y="92.9868" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="250" B="150" />
                <PrePosition X="0.5259" Y="0.7948" />
                <PreSize X="0.3333" Y="0.2051" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_Refuse" ActionTag="-824254983" Tag="430" IconVisible="False" LeftMargin="400.0797" RightMargin="187.9203" TopMargin="49.9617" BottomMargin="13.0383" TouchEnable="True" FontSize="24" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="102" Scale9Height="32" OutlineSize="0" ShadowOffsetX="0" ShadowOffsetY="0" ctype="ButtonObjectData">
                <Size X="132.0000" Y="54.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="466.0797" Y="40.0383" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.6473" Y="0.3422" />
                <PreSize X="0.1833" Y="0.4615" />
                <TextColor A="255" R="255" G="255" B="255" />
                <NormalFileData Type="Normal" Path="hallcocosstudio/images/png/charteredroom/Game_BtnDismiss.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_Accept" ActionTag="-2049340182" Tag="431" IconVisible="False" LeftMargin="544.5776" RightMargin="43.4224" TopMargin="49.9600" BottomMargin="13.0400" TouchEnable="True" FontSize="24" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="102" Scale9Height="32" OutlineSize="0" ShadowOffsetX="0" ShadowOffsetY="0" ctype="ButtonObjectData">
                <Size X="132.0000" Y="54.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="610.5776" Y="40.0400" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8480" Y="0.3422" />
                <PreSize X="0.1833" Y="0.4615" />
                <TextColor A="255" R="255" G="255" B="255" />
                <NormalFileData Type="Normal" Path="hallcocosstudio/images/png/charteredroom/Game_BtnAccept.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
              <AbstractNodeData Name="Text_Right" ActionTag="1330959415" Tag="59" VisibleForFrame="False" IconVisible="False" LeftMargin="92.5399" RightMargin="527.4601" TopMargin="13.1600" BottomMargin="83.8400" FontSize="20" LabelText="Text Label" OutlineSize="0" ShadowOffsetX="0" ShadowOffsetY="0" ctype="TextObjectData">
                <Size X="100.0000" Y="20.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="142.5399" Y="93.8400" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.1980" Y="0.8021" />
                <PreSize X="0.1389" Y="0.1709" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Text_Forbidden" ActionTag="1368549433" Tag="434" IconVisible="False" LeftMargin="97.4865" RightMargin="502.5135" TopMargin="65.4603" BottomMargin="31.5397" FontSize="20" LabelText="今日不再提醒" OutlineSize="0" ShadowOffsetX="0" ShadowOffsetY="0" ctype="TextObjectData">
                <Size X="120.0000" Y="20.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="157.4865" Y="41.5397" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="250" B="150" />
                <PrePosition X="0.2187" Y="0.3550" />
                <PreSize X="0.1667" Y="0.1709" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
              <AbstractNodeData Name="Check_Forbidden" ActionTag="962233242" Tag="433" IconVisible="False" LeftMargin="39.9237" RightMargin="620.0763" TopMargin="44.0068" BottomMargin="12.9932" TouchEnable="True" ctype="CheckBoxObjectData">
                <Size X="60.0000" Y="60.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="69.9237" Y="42.9932" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.0971" Y="0.3675" />
                <PreSize X="0.0833" Y="0.5128" />
                <NormalBackFileData Type="Normal" Path="hallcocosstudio/images/png/charteredroom/Game_CheckboxBG_1.png" Plist="" />
                <PressedBackFileData Type="Normal" Path="hallcocosstudio/images/png/charteredroom/Game_CheckboxBG_1.png" Plist="" />
                <DisableBackFileData Type="Normal" Path="hallcocosstudio/images/png/charteredroom/Game_CheckboxBG_1.png" Plist="" />
                <NodeNormalFileData Type="Normal" Path="hallcocosstudio/images/png/charteredroom/Game_CheckboxTick_1.png" Plist="" />
                <NodeDisableFileData Type="Normal" Path="hallcocosstudio/images/png/charteredroom/Game_CheckboxTick_1.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="1.0000" />
            <Position Y="117.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
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