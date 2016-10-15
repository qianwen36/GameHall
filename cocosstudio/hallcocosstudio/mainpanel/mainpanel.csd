<GameFile>
  <PropertyGroup Name="MainPanel" Type="Scene" ID="1da575bc-753b-4e1c-8a97-8f7242ae1953" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="180" Speed="1.0000">
        <Timeline ActionTag="-992360272" Property="Position">
          <PointFrame FrameIndex="0" X="69.6396" Y="50.8312">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="9" X="122.6392" Y="48.8313">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="18" X="182.6402" Y="48.8313">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="26" X="222.6398" Y="47.8313">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="34" X="262.6405" Y="50.8312">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="40" X="287.6409" Y="49.8312">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="180" X="757.6371" Y="140.8311">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="-992360272" Property="Alpha">
          <IntFrame FrameIndex="0" Value="0">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="9" Value="127">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="18" Value="255">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="26" Value="148">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="34" Value="102">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="40" Value="0">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="180" Value="0">
            <EasingData Type="0" />
          </IntFrame>
        </Timeline>
        <Timeline ActionTag="380328507" Property="Alpha">
          <IntFrame FrameIndex="0" Value="0">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="40" Value="255">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="80" Value="0">
            <EasingData Type="0" />
          </IntFrame>
        </Timeline>
        <Timeline ActionTag="1064086689" Property="Alpha">
          <IntFrame FrameIndex="0" Value="0">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="36" Value="20">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="50" Value="255">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="60" Value="255">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="80" Value="0">
            <EasingData Type="0" />
          </IntFrame>
        </Timeline>
        <Timeline ActionTag="1064086689" Property="Scale">
          <ScaleFrame FrameIndex="36" X="0.5000" Y="0.5000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="50" X="1.1000" Y="1.1000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="65" X="0.9000" Y="0.9000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="80" X="0.0100" Y="0.0100">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="1064086689" Property="RotationSkew">
          <ScaleFrame FrameIndex="0" X="-45.0037" Y="-45.0062">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="36" X="-44.9994" Y="-45.0062">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="75" X="28.0955" Y="28.0853">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
      </Animation>
      <AnimationList>
        <AnimationInfo Name="saoguang" StartIndex="0" EndIndex="40">
          <RenderColor A="255" R="255" G="239" B="213" />
        </AnimationInfo>
      </AnimationList>
      <ObjectData Name="Scene" ctype="GameNodeObjectData">
        <Size X="1280.0000" Y="720.0000" />
        <Children>
          <AbstractNodeData Name="Image_BackGround" ActionTag="-2043962936" Tag="69" IconVisible="False" TopMargin="-0.0006" BottomMargin="0.0006" StretchHeightEnable="True" Scale9Width="1280" Scale9Height="720" ctype="ImageViewObjectData">
            <Size X="1280.0000" Y="720.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="640.0000" Y="360.0006" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="1.0000" Y="1.0000" />
            <FileData Type="Normal" Path="HallCocosStudio/images/BG.jpg" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="Panel_Player" ActionTag="1825374151" Tag="16" IconVisible="False" HorizontalEdge="LeftEdge" VerticalEdge="TopEdge" LeftMargin="6.1317" RightMargin="893.8683" TopMargin="6.2093" BottomMargin="613.7907" TouchEnable="True" ClipAble="False" ColorAngle="90.0000" ctype="PanelObjectData">
            <Size X="380.0000" Y="100.0000" />
            <Children>
              <AbstractNodeData Name="Button_Head" ActionTag="-11959085" Tag="17" IconVisible="False" LeftMargin="14.0769" RightMargin="280.9231" TopMargin="8.7756" BottomMargin="7.2244" TouchEnable="True" FontSize="14" Scale9Enable="True" Scale9Width="85" Scale9Height="84" OutlineSize="0" ShadowOffsetX="0.0000" ShadowOffsetY="0.0000" ctype="ButtonObjectData">
                <Size X="85.0000" Y="84.0000" />
                <Children>
                  <AbstractNodeData Name="Image_Girl" ActionTag="-595045583" Tag="24" IconVisible="False" LeftMargin="-0.3459" RightMargin="0.3459" TopMargin="-0.4378" BottomMargin="0.4378" Scale9Width="85" Scale9Height="84" ctype="ImageViewObjectData">
                    <Size X="85.0000" Y="84.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="42.1541" Y="42.4378" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.4959" Y="0.5052" />
                    <PreSize X="0.2125" Y="0.7000" />
                    <FileData Type="Normal" Path="HallCocosStudio/images/gir.head_pic.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_Boy" ActionTag="-506222610" Tag="23" IconVisible="False" LeftMargin="1.0298" RightMargin="-1.0298" TopMargin="-0.4378" BottomMargin="0.4378" Scale9Width="85" Scale9Height="84" ctype="ImageViewObjectData">
                    <Size X="85.0000" Y="84.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="43.5298" Y="42.4378" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5121" Y="0.5052" />
                    <PreSize X="0.2125" Y="0.7000" />
                    <FileData Type="Normal" Path="HallCocosStudio/images/boy.head_pic.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_4" Visible="False" ActionTag="1141862418" Tag="84" IconVisible="False" LeftMargin="-6.5004" RightMargin="62.5004" TopMargin="55.9993" BottomMargin="-1.9993" Scale9Width="29" Scale9Height="30" ctype="ImageViewObjectData">
                    <Size X="29.0000" Y="30.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="7.9996" Y="13.0007" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.0941" Y="0.1548" />
                    <PreSize X="0.0763" Y="0.3000" />
                    <FileData Type="Normal" Path="HallCocosStudio/images/txsz_pic.png" Plist="" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="56.5769" Y="49.2244" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.1489" Y="0.4922" />
                <PreSize X="0.4250" Y="0.4200" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                <PressedFileData Type="Normal" Path="HallCocosStudio/images/bg.head_pic.png" Plist="" />
                <NormalFileData Type="Normal" Path="HallCocosStudio/images/bg.head_pic.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
              <AbstractNodeData Name="Text_Name" ActionTag="1964355875" Tag="18" IconVisible="False" LeftMargin="120.2427" RightMargin="175.7573" TopMargin="11.8806" BottomMargin="60.1194" FontSize="28" LabelText="未登录" OutlineSize="0" ShadowOffsetX="0.0000" ShadowOffsetY="0.0000" ctype="TextObjectData">
                <Size X="84.0000" Y="28.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="120.2427" Y="74.1194" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="46" G="46" B="46" />
                <PrePosition X="0.3164" Y="0.7412" />
                <PreSize X="0.0000" Y="0.0000" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
              <AbstractNodeData Name="Image_1" ActionTag="1864833950" Tag="342" IconVisible="False" HorizontalEdge="BothEdge" VerticalEdge="BothEdge" LeftMargin="113.3160" RightMargin="-13.3160" TopMargin="43.4800" BottomMargin="4.5200" Scale9Enable="True" LeftEage="26" RightEage="26" TopEage="26" BottomEage="26" Scale9OriginX="26" Scale9OriginY="26" Scale9Width="10" Scale9Height="1" ctype="ImageViewObjectData">
                <Size X="280.0000" Y="52.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="113.3160" Y="30.5200" />
                <Scale ScaleX="0.8500" ScaleY="0.8500" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2982" Y="0.3052" />
                <PreSize X="0.7368" Y="0.5200" />
                <FileData Type="Normal" Path="HallCocosStudio/images/box11_pic.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Button_Charge" ActionTag="1692903373" VisibleForFrame="False" Tag="20" IconVisible="False" LeftMargin="309.6606" RightMargin="24.3394" TopMargin="46.3596" BottomMargin="7.6404" TouchEnable="True" FontSize="14" Scale9Enable="True" Scale9Width="42" Scale9Height="42" OutlineSize="0" ShadowOffsetX="0.0000" ShadowOffsetY="0.0000" ctype="ButtonObjectData">
                <Size X="46.0000" Y="46.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="332.6606" Y="30.6404" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8754" Y="0.3064" />
                <PreSize X="0.1211" Y="0.4600" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                <PressedFileData Type="Normal" Path="HallCocosStudio/images/jq_btn.png" Plist="" />
                <NormalFileData Type="Normal" Path="HallCocosStudio/images/jq_btn.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
              <AbstractNodeData Name="AtlasLabel_3" ActionTag="-1455857967" VisibleForFrame="False" Tag="21" IconVisible="False" LeftMargin="155.8339" RightMargin="96.1661" TopMargin="54.3376" BottomMargin="13.6624" CharWidth="32" CharHeight="32" LabelText="8888" StartChar="." ctype="TextAtlasObjectData">
                <Size X="128.0000" Y="32.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="155.8339" Y="29.6624" />
                <Scale ScaleX="0.7500" ScaleY="0.7500" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4101" Y="0.2966" />
                <PreSize X="0.5895" Y="0.3200" />
                <LabelAtlasFileImage_CNB Type="Normal" Path="HallCocosStudio/images/shuzi2_pic.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Image_2" ActionTag="-998462485" Tag="22" IconVisible="False" LeftMargin="129.1500" RightMargin="207.8500" TopMargin="55.7223" BottomMargin="13.2777" Scale9Width="43" Scale9Height="31" ctype="ImageViewObjectData">
                <Size X="43.0000" Y="31.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="150.6500" Y="28.7777" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3964" Y="0.2878" />
                <PreSize X="0.1075" Y="0.2583" />
                <FileData Type="Normal" Path="HallCocosStudio/images/yinzi_pic.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Image_Mem" ActionTag="-564639399" Tag="25" IconVisible="False" LeftMargin="304.3923" RightMargin="33.6077" TopMargin="7.5005" BottomMargin="54.4995" Scale9Width="27" Scale9Height="22" ctype="ImageViewObjectData">
                <Size X="42.0000" Y="38.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="325.3923" Y="73.4995" />
                <Scale ScaleX="0.8000" ScaleY="0.8000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8563" Y="0.7350" />
                <PreSize X="0.1105" Y="0.3800" />
                <FileData Type="Normal" Path="HallCocosStudio/images/lanzuan_pic.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Text_Deposit" ActionTag="-692075462" Tag="111" IconVisible="False" LeftMargin="181.8000" RightMargin="58.2000" TopMargin="55.6801" BottomMargin="16.3199" FontSize="28" LabelText="9999999999" OutlineSize="0" ShadowOffsetX="0.0000" ShadowOffsetY="0.0000" ctype="TextObjectData">
                <Size X="140.0000" Y="28.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="181.8000" Y="30.3199" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="46" G="46" B="46" />
                <PrePosition X="0.4784" Y="0.3032" />
                <PreSize X="0.0000" Y="0.0000" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position X="6.1317" Y="613.7907" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.0048" Y="0.8525" />
            <PreSize X="0.5278" Y="0.0781" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Panel_Name" ActionTag="-718359634" Tag="26" IconVisible="False" VerticalEdge="TopEdge" LeftMargin="170.0000" RightMargin="170.0000" BottomMargin="620.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" ctype="PanelObjectData">
            <Size X="940.0000" Y="100.0000" />
            <Children>
              <AbstractNodeData Name="Image_Name" ActionTag="-2121768195" Tag="27" IconVisible="False" HorizontalEdge="BothEdge" VerticalEdge="TopEdge" LeftMargin="291.8460" RightMargin="290.1541" TopMargin="1.0232" BottomMargin="7.9768" Scale9Width="358" Scale9Height="91" ctype="ImageViewObjectData">
                <Size X="358.0000" Y="91.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="470.8460" Y="53.4768" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5009" Y="0.5348" />
                <PreSize X="1.1933" Y="0.7583" />
                <FileData Type="Normal" Path="HallCocosStudio/images/LOGO_bg_pic.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Image_Back" ActionTag="1719703591" Tag="28" IconVisible="False" HorizontalEdge="BothEdge" VerticalEdge="TopEdge" LeftMargin="292.5040" RightMargin="289.4960" TopMargin="-4.1596" BottomMargin="13.1596" Scale9Width="358" Scale9Height="91" ctype="ImageViewObjectData">
                <Size X="358.0000" Y="91.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="471.5040" Y="58.6596" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5016" Y="0.5866" />
                <PreSize X="0.9421" Y="0.7583" />
                <FileData Type="Normal" Path="HallCocosStudio/images/logo_pic.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="1.0000" />
            <Position X="640.0000" Y="720.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="1.0000" />
            <PreSize X="0.7344" Y="0.1389" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Panel_RightUp" ActionTag="-1019634782" Tag="29" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="840.0000" BottomMargin="620.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" ctype="PanelObjectData">
            <Size X="440.0000" Y="100.0000" />
            <Children>
              <AbstractNodeData Name="Button_Setting" ActionTag="1095665619" Tag="30" IconVisible="False" LeftMargin="352.9607" RightMargin="28.0393" TopMargin="17.7962" BottomMargin="21.2038" TouchEnable="True" FontSize="14" Scale9Enable="True" Scale9Width="59" Scale9Height="61" OutlineSize="0" ShadowOffsetX="0.0000" ShadowOffsetY="0.0000" ctype="ButtonObjectData">
                <Size X="59.0000" Y="61.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="382.4607" Y="51.7038" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8692" Y="0.5170" />
                <PreSize X="0.1229" Y="0.5083" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                <PressedFileData Type="Normal" Path="HallCocosStudio/images/sz_btn.png" Plist="" />
                <NormalFileData Type="Normal" Path="HallCocosStudio/images/sz_btn.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
              <AbstractNodeData Name="Button_Help" ActionTag="213806357" Tag="31" IconVisible="False" LeftMargin="239.6251" RightMargin="141.3749" TopMargin="17.7962" BottomMargin="21.2038" TouchEnable="True" FontSize="14" Scale9Enable="True" Scale9Width="59" Scale9Height="61" OutlineSize="0" ShadowOffsetX="0.0000" ShadowOffsetY="0.0000" ctype="ButtonObjectData">
                <Size X="59.0000" Y="61.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="269.1251" Y="51.7038" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.6116" Y="0.5170" />
                <PreSize X="0.1229" Y="0.5083" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                <PressedFileData Type="Normal" Path="HallCocosStudio/images/bz_btn.png" Plist="" />
                <NormalFileData Type="Normal" Path="HallCocosStudio/images/bz_btn.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
              <AbstractNodeData Name="Button_Activity" ActionTag="2112522583" Tag="32" IconVisible="False" LeftMargin="123.7810" RightMargin="257.2190" TopMargin="17.7962" BottomMargin="21.2038" TouchEnable="True" FontSize="14" Scale9Enable="True" Scale9Width="59" Scale9Height="61" OutlineSize="0" ShadowOffsetX="0.0000" ShadowOffsetY="0.0000" ctype="ButtonObjectData">
                <Size X="59.0000" Y="61.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="153.2810" Y="51.7038" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3484" Y="0.5170" />
                <PreSize X="0.1229" Y="0.5083" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                <PressedFileData Type="Normal" Path="HallCocosStudio/images/qd_btn.png" Plist="" />
                <NormalFileData Type="Normal" Path="HallCocosStudio/images/qd_btn.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
              <AbstractNodeData Name="Image_MsgTip" ActionTag="-1612323461" VisibleForFrame="False" Tag="69" IconVisible="False" HorizontalEdge="BothEdge" LeftMargin="166.8920" RightMargin="251.1080" TopMargin="17.9433" BottomMargin="60.0567" Scale9Width="22" Scale9Height="22" ctype="ImageViewObjectData">
                <Size X="22.0000" Y="22.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="177.8920" Y="71.0567" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4043" Y="0.7106" />
                <PreSize X="0.0500" Y="0.2200" />
                <FileData Type="Normal" Path="HallCocosStudio/images/hongdian_pic.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Image_NewsTip" ActionTag="339807112" VisibleForFrame="False" Tag="70" IconVisible="False" HorizontalEdge="BothEdge" LeftMargin="276.3640" RightMargin="141.6360" TopMargin="17.9433" BottomMargin="60.0567" Scale9Width="22" Scale9Height="22" ctype="ImageViewObjectData">
                <Size X="22.0000" Y="22.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="287.3640" Y="71.0567" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.6531" Y="0.7106" />
                <PreSize X="0.0500" Y="0.2200" />
                <FileData Type="Normal" Path="HallCocosStudio/images/hongdian_pic.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="1.0000" ScaleY="1.0000" />
            <Position X="1280.0000" Y="720.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="1.0000" Y="1.0000" />
            <PreSize X="0.3438" Y="0.1389" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Panel_Down" ActionTag="732673685" Tag="42" IconVisible="False" HorizontalEdge="BothEdge" VerticalEdge="BottomEdge" TopMargin="530.0000" TouchEnable="True" StretchWidthEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" ctype="PanelObjectData">
            <Size X="1280.0000" Y="190.0000" />
            <Children>
              <AbstractNodeData Name="Image_Back" ActionTag="1439132834" Tag="52" IconVisible="False" HorizontalEdge="BothEdge" VerticalEdge="BottomEdge" LeftMargin="-0.0045" RightMargin="0.0045" TopMargin="95.4995" BottomMargin="-0.4995" StretchWidthEnable="True" Scale9Enable="True" LeftEage="200" RightEage="200" Scale9OriginX="200" Scale9Width="880" Scale9Height="95" ctype="ImageViewObjectData">
                <Size X="1280.0000" Y="95.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="639.9955" Y="47.0005" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.2474" />
                <PreSize X="1.0000" Y="0.5000" />
                <FileData Type="Normal" Path="HallCocosStudio/images/antai_pic.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Button_quick_start" ActionTag="-2005500522" Tag="44" IconVisible="False" HorizontalEdge="BothEdge" LeftMargin="465.5000" RightMargin="465.5000" TopMargin="-5.3300" BottomMargin="99.3300" TouchEnable="True" FontSize="14" Scale9Enable="True" Scale9Width="349" Scale9Height="96" OutlineSize="0" ShadowOffsetX="0.0000" ShadowOffsetY="0.0000" ctype="ButtonObjectData">
                <Size X="349.0000" Y="96.0000" />
                <Children>
                  <AbstractNodeData Name="Image_2" ActionTag="-992360272" Alpha="0" Tag="2962" IconVisible="False" LeftMargin="37.1396" RightMargin="246.8604" TopMargin="5.6688" BottomMargin="11.3312" Scale9Width="65" Scale9Height="79" ctype="ImageViewObjectData">
                    <Size X="65.0000" Y="79.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="69.6396" Y="50.8312" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.1995" Y="0.5295" />
                    <PreSize X="0.0508" Y="0.1097" />
                    <FileData Type="Normal" Path="HallCocosStudio/images/guang_pic.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_2_0" ActionTag="380328507" Alpha="0" Tag="43" IconVisible="False" LeftMargin="17.8874" RightMargin="20.1126" TopMargin="-4.4472" BottomMargin="-1.5528" Scale9Width="311" Scale9Height="102" ctype="ImageViewObjectData">
                    <Size X="311.0000" Y="102.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="173.3874" Y="49.4472" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.4968" Y="0.5151" />
                    <PreSize X="0.2430" Y="0.1417" />
                    <FileData Type="Normal" Path="HallCocosStudio/images/guang2_pic.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_2_0_0" ActionTag="1064086689" Alpha="0" Tag="1410" RotationSkewX="-45.0037" RotationSkewY="-45.0062" IconVisible="False" LeftMargin="257.9998" RightMargin="27.0002" TopMargin="-17.4999" BottomMargin="48.4999" Scale9Width="64" Scale9Height="65" Rotation="-45.0037" ctype="ImageViewObjectData">
                    <Size X="64.0000" Y="65.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="289.9998" Y="80.9999" />
                    <Scale ScaleX="0.5000" ScaleY="0.5000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.8309" Y="0.8437" />
                    <PreSize X="0.0500" Y="0.0903" />
                    <FileData Type="Normal" Path="HallCocosStudio/images/shanguang_pic.png" Plist="" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="640.0000" Y="147.3300" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.7754" />
                <PreSize X="0.2727" Y="0.5053" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                <PressedFileData Type="Normal" Path="HallCocosStudio/images/ksks_btn.png" Plist="" />
                <NormalFileData Type="Normal" Path="HallCocosStudio/images/ksks_btn.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
              <AbstractNodeData Name="Button_safebox" ActionTag="1769420678" Tag="36" IconVisible="False" HorizontalEdge="BothEdge" LeftMargin="168.3760" RightMargin="925.6240" TopMargin="95.5000" BottomMargin="1.5000" TouchEnable="True" FontSize="14" Scale9Enable="True" Scale9Width="186" Scale9Height="93" OutlineSize="0" ShadowOffsetX="0.0000" ShadowOffsetY="0.0000" ctype="ButtonObjectData">
                <Size X="186.0000" Y="93.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="261.3760" Y="48.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2042" Y="0.2526" />
                <PreSize X="0.1453" Y="0.4895" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                <PressedFileData Type="Normal" Path="HallCocosStudio/images/bxx_btn.png" Plist="" />
                <NormalFileData Type="Normal" Path="HallCocosStudio/images/bxx_btn.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
              <AbstractNodeData Name="Button_Shop" ActionTag="1039606892" Tag="37" IconVisible="False" HorizontalEdge="BothEdge" LeftMargin="425.1440" RightMargin="668.8560" TopMargin="95.5000" BottomMargin="1.5000" TouchEnable="True" FontSize="14" Scale9Enable="True" Scale9Width="186" Scale9Height="93" OutlineSize="0" ShadowOffsetX="0.0000" ShadowOffsetY="0.0000" ctype="ButtonObjectData">
                <Size X="186.0000" Y="93.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="518.1440" Y="48.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4048" Y="0.2526" />
                <PreSize X="0.1453" Y="0.4895" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                <PressedFileData Type="Normal" Path="HallCocosStudio/images/sc_btn.png" Plist="" />
                <NormalFileData Type="Normal" Path="HallCocosStudio/images/sc_btn.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
              <AbstractNodeData Name="Button_Activity" ActionTag="952230951" Tag="38" IconVisible="False" HorizontalEdge="BothEdge" LeftMargin="681.7840" RightMargin="412.2160" TopMargin="95.5000" BottomMargin="1.5000" TouchEnable="True" FontSize="14" Scale9Enable="True" Scale9Width="186" Scale9Height="93" OutlineSize="0" ShadowOffsetX="0.0000" ShadowOffsetY="0.0000" ctype="ButtonObjectData">
                <Size X="186.0000" Y="93.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="774.7840" Y="48.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.6053" Y="0.2526" />
                <PreSize X="0.1453" Y="0.4895" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                <PressedFileData Type="Normal" Path="HallCocosStudio/images/hd_btn.png" Plist="" />
                <NormalFileData Type="Normal" Path="HallCocosStudio/images/hd_btn.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
              <AbstractNodeData Name="Image_ActMsg" ActionTag="123957196" VisibleForFrame="False" Tag="68" IconVisible="False" HorizontalEdge="BothEdge" LeftMargin="747.6560" RightMargin="510.3440" TopMargin="100.8195" BottomMargin="67.1805" Scale9Width="22" Scale9Height="22" ctype="ImageViewObjectData">
                <Size X="22.0000" Y="22.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="758.6560" Y="78.1805" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5927" Y="0.4115" />
                <PreSize X="0.0172" Y="0.1158" />
                <FileData Type="Normal" Path="HallCocosStudio/images/hongdian_pic.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize X="1.0000" Y="0.2639" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Area_List" ActionTag="1964919306" VisibleForFrame="False" Tag="263" IconVisible="False" TopMargin="126.0000" BottomMargin="214.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" IsBounceEnabled="True" ScrollDirectionType="Horizontal" ctype="ScrollViewObjectData">
            <Size X="1280.0000" Y="380.0000" />
            <AnchorPoint />
            <Position Y="214.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition Y="0.2972" />
            <PreSize X="1.0000" Y="0.5278" />
            <SingleColor A="255" R="255" G="150" B="100" />
            <FirstColor A="255" R="255" G="150" B="100" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
            <InnerNodeSize Width="2180" Height="380" />
          </AbstractNodeData>
          <AbstractNodeData Name="Room_List" ActionTag="1168925877" VisibleForFrame="False" Tag="264" IconVisible="False" TopMargin="126.0000" BottomMargin="214.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" IsBounceEnabled="True" ScrollDirectionType="Horizontal" ctype="ScrollViewObjectData">
            <Size X="1280.0000" Y="380.0000" />
            <AnchorPoint />
            <Position Y="214.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition Y="0.2972" />
            <PreSize X="1.0000" Y="0.5278" />
            <SingleColor A="255" R="255" G="150" B="100" />
            <FirstColor A="255" R="255" G="150" B="100" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
            <InnerNodeSize Width="1880" Height="380" />
          </AbstractNodeData>
          <AbstractNodeData Name="Panel_Forbidden" ActionTag="695668371" VisibleForFrame="False" Tag="39" IconVisible="False" TopMargin="126.0000" BottomMargin="214.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" ctype="PanelObjectData">
            <Size X="1280.0000" Y="380.0000" />
            <AnchorPoint />
            <Position Y="214.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition Y="0.2972" />
            <PreSize X="1.0000" Y="0.5278" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Particle_Flower" ActionTag="-608920158" Tag="34" IconVisible="False" HorizontalEdge="BothEdge" VerticalEdge="TopEdge" LeftMargin="1030.6560" RightMargin="249.3440" TopMargin="-49.2248" BottomMargin="769.2248" ctype="ParticleObjectData">
            <Size X="0.0000" Y="0.0000" />
            <AnchorPoint />
            <Position X="1030.6560" Y="769.2248" />
            <Scale ScaleX="1.0000" ScaleY="0.8718" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.8052" Y="1.0684" />
            <PreSize X="0.0000" Y="0.0000" />
            <FileData Type="Normal" Path="HallCocosStudio/particle/huaban.plist" Plist="" />
            <BlendFunc Src="1" Dst="771" />
          </AbstractNodeData>
          <AbstractNodeData Name="Particle_Flower" ActionTag="-743283875" Tag="35" IconVisible="False" HorizontalEdge="BothEdge" VerticalEdge="TopEdge" LeftMargin="282.3680" RightMargin="997.6320" TopMargin="-49.2248" BottomMargin="769.2248" ctype="ParticleObjectData">
            <Size X="0.0000" Y="0.0000" />
            <AnchorPoint />
            <Position X="282.3680" Y="769.2248" />
            <Scale ScaleX="1.0000" ScaleY="0.8718" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.2206" Y="1.0684" />
            <PreSize X="0.0000" Y="0.0000" />
            <FileData Type="Normal" Path="HallCocosStudio/particle/huaban.plist" Plist="" />
            <BlendFunc Src="1" Dst="771" />
          </AbstractNodeData>
          <AbstractNodeData Name="Btn_To_Area" ActionTag="1459624371" VisibleForFrame="False" Tag="59" IconVisible="False" LeftMargin="14.7856" RightMargin="1185.2144" TopMargin="112.1422" BottomMargin="535.8578" TouchEnable="True" FontSize="14" Scale9Enable="True" Scale9Width="85" Scale9Height="84" OutlineSize="0" ShadowOffsetX="0.0000" ShadowOffsetY="0.0000" ctype="ButtonObjectData">
            <Size X="80.0000" Y="72.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="54.7856" Y="571.8578" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.0428" Y="0.7942" />
            <PreSize X="0.0625" Y="0.1000" />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Normal" Path="HallCocosStudio/images/fh_btn.png" Plist="" />
            <NormalFileData Type="Normal" Path="HallCocosStudio/images/fh_btn.png" Plist="" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="255" G="127" B="80" />
          </AbstractNodeData>
          <AbstractNodeData Name="Text_Channel" ActionTag="-1127509687" Tag="51" IconVisible="False" LeftMargin="179.7911" RightMargin="1100.2089" TopMargin="141.8130" BottomMargin="578.1870" FontSize="36" LabelText="" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
            <Size X="0.0000" Y="0.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="179.7911" Y="578.1870" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.1405" Y="0.8030" />
            <PreSize X="0.0000" Y="0.0000" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="255" G="127" B="80" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>