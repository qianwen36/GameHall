<GameProjectFile>
  <PropertyGroup Type="Node" Name="Node_firstcharge" ID="011a7de2-959a-43f9-8a1d-539f686ca7c2" Version="2.3.0.1" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="60" Speed="0.3333">
        <Timeline ActionTag="172309693" Property="Position">
          <PointFrame FrameIndex="1" X="327.9967" Y="420.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="29" X="328.0000" Y="420.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="60" X="328.0000" Y="420.0000">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="172309693" Property="Scale">
          <ScaleFrame FrameIndex="1" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="29" X="0.5000" Y="0.5000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="60" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="172309693" Property="RotationSkew">
          <ScaleFrame FrameIndex="1" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="29" X="170.8475" Y="170.8475">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="60" X="360.0000" Y="360.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="-556685337" Property="Position">
          <PointFrame FrameIndex="1" X="327.9999" Y="419.9970">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="29" X="328.0000" Y="420.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="60" X="328.0000" Y="420.0000">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="-556685337" Property="Scale">
          <ScaleFrame FrameIndex="1" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="29" X="0.8000" Y="0.8000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="60" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="-556685337" Property="RotationSkew">
          <ScaleFrame FrameIndex="1" X="5.0002" Y="5.0002">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="29" X="178.7931" Y="178.7931">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="60" X="365.0000" Y="365.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
      </Animation>
      <AnimationList>
        <AnimationInfo Name="animation_light" StartIndex="1" EndIndex="60">
          <RenderColor A="255" R="210" G="180" B="140" />
        </AnimationInfo>
      </AnimationList>
      <ObjectData Name="Node" Tag="164" ctype="GameNodeObjectData">
        <Size />
        <Children>
          <AbstractNodeData Name="Panel_shade" ActionTag="-1214701692" Tag="136" Alpha="128" IconVisible="False" LeftMargin="-640.0000" RightMargin="-640.0000" TopMargin="-640.0000" BottomMargin="-640.0000" TouchEnable="True" BackColorAlpha="178" ComboBoxIndex="1" ColorAngle="90.0000" ctype="PanelObjectData">
            <Size X="1280.0000" Y="1280.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <SingleColor A="255" R="0" G="0" B="0" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Panel_main" ActionTag="-321521429" Tag="59" IconVisible="False" LeftMargin="-329.5000" RightMargin="-329.5000" TopMargin="-221.0000" BottomMargin="-221.0000" TouchEnable="True" BackColorAlpha="102" ColorAngle="90.0000" ctype="PanelObjectData">
            <Size X="659.0000" Y="442.0000" />
            <Children>
              <AbstractNodeData Name="BGlight_1" ActionTag="172309693" Tag="65" Rotation="128.1356" RotationSkewX="128.1356" RotationSkewY="128.1356" IconVisible="False" LeftMargin="100.4992" RightMargin="103.5009" TopMargin="-205.5000" BottomMargin="192.5000" Scale9Width="455" Scale9Height="455" ctype="ImageViewObjectData">
                <Size X="455.0000" Y="455.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="327.9992" Y="420.0000" />
                <Scale ScaleX="0.6250" ScaleY="0.6250" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4977" Y="0.9502" />
                <PreSize X="0.6904" Y="1.0294" />
                <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/FirstCharge_Img/Firstcharge_BGLight.png" Plist="hallcocosstudio/images/plist/FirstCharge_Img.plist" />
              </AbstractNodeData>
              <AbstractNodeData Name="BGlight_2" ActionTag="-556685337" Tag="66" Rotation="135.3449" RotationSkewX="135.3449" RotationSkewY="135.3449" IconVisible="False" LeftMargin="100.5000" RightMargin="103.5000" TopMargin="-205.4993" BottomMargin="192.4993" Scale9Width="455" Scale9Height="455" ctype="ImageViewObjectData">
                <Size X="455.0000" Y="455.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="328.0000" Y="419.9993" />
                <Scale ScaleX="0.8500" ScaleY="0.8500" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4977" Y="0.9502" />
                <PreSize X="0.6904" Y="1.0294" />
                <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/FirstCharge_Img/Firstcharge_BGLight.png" Plist="hallcocosstudio/images/plist/FirstCharge_Img.plist" />
              </AbstractNodeData>
              <AbstractNodeData Name="box_main" ActionTag="2079197067" Tag="60" IconVisible="False" HorizontalEdge="LeftEdge" VerticalEdge="TopEdge" LeftMargin="-39.0000" RightMargin="-39.0000" TopMargin="-43.5000" BottomMargin="-43.5000" Scale9Width="737" Scale9Height="529" ctype="ImageViewObjectData">
                <Size X="737.0000" Y="529.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="329.5000" Y="221.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.5000" />
                <PreSize X="1.1184" Y="1.1968" />
                <FileData Type="Normal" Path="hallcocosstudio/images/png/FirstCharge_BG.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="title_firstcharge" ActionTag="887247156" Tag="61" IconVisible="False" LeftMargin="179.4999" RightMargin="182.5001" TopMargin="-41.9575" BottomMargin="404.9575" Scale9Width="95" Scale9Height="26" ctype="ImageViewObjectData">
                <Size X="297.0000" Y="79.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="327.9999" Y="444.4575" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4977" Y="1.0056" />
                <PreSize X="0.4507" Y="0.1787" />
                <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/FirstCharge_Img/FirstCharge_Title.png" Plist="hallcocosstudio/images/plist/FirstCharge_Img.plist" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_charge" ActionTag="1709185269" Tag="62" IconVisible="False" LeftMargin="150.0000" RightMargin="150.0000" TopMargin="336.6443" BottomMargin="14.3557" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="329" Scale9Height="69" OutlineSize="0" ShadowOffsetX="0" ShadowOffsetY="0" ctype="ButtonObjectData">
                <Size X="359.0000" Y="91.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="329.5000" Y="59.8557" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.1354" />
                <PreSize X="0.5448" Y="0.2059" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/FirstCharge_Img/FirstCharge_Btn_Reward.png" Plist="hallcocosstudio/images/plist/FirstCharge_Img.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
              <AbstractNodeData Name="text_add" ActionTag="1206545569" Tag="64" IconVisible="False" LeftMargin="311.8678" RightMargin="295.1322" TopMargin="184.0356" BottomMargin="199.9644" ctype="SpriteObjectData">
                <Size X="52.0000" Y="58.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="337.8678" Y="228.9644" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5127" Y="0.5180" />
                <PreSize />
                <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/FirstCharge_Img/FirstCharge_IconAdd.png" Plist="hallcocosstudio/images/plist/FirstCharge_Img.plist" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="text_dot_1_0" ActionTag="-1735636772" Tag="56" IconVisible="False" LeftMargin="485.4968" RightMargin="130.5032" TopMargin="55.0011" BottomMargin="358.9989" FlipX="True" ctype="SpriteObjectData">
                <Size X="43.0000" Y="28.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="506.9968" Y="372.9989" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7693" Y="0.8439" />
                <PreSize />
                <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/FirstCharge_Img/FirstCharge_AttentionDot.png" Plist="hallcocosstudio/images/plist/FirstCharge_Img.plist" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="text_dot_1" ActionTag="-1106587057" Tag="55" IconVisible="False" LeftMargin="123.5010" RightMargin="492.4990" TopMargin="55.0011" BottomMargin="358.9989" ctype="SpriteObjectData">
                <Size X="43.0000" Y="28.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="145.0010" Y="372.9989" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2200" Y="0.8439" />
                <PreSize />
                <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/FirstCharge_Img/FirstCharge_AttentionDot.png" Plist="hallcocosstudio/images/plist/FirstCharge_Img.plist" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="text_firstcharge_detail" ActionTag="-1223952930" Tag="20" Alpha="253" IconVisible="False" LeftMargin="215.5000" RightMargin="218.5000" TopMargin="53.0022" BottomMargin="358.9978" LabelText="首充2元可得大礼" ctype="TextBMFontObjectData">
                <Size X="225.0000" Y="30.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="328.0000" Y="373.9978" />
                <Scale ScaleX="1.3000" ScaleY="1.3000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4977" Y="0.8461" />
                <PreSize />
                <LabelBMFontFile_CNB Type="Normal" Path="hallcocosstudio/images/font/shop_firstcharge.fnt" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Panel_item_1" ActionTag="1469114276" Tag="67" IconVisible="False" LeftMargin="55.7369" RightMargin="365.2631" TopMargin="107.9999" BottomMargin="124.0001" TouchEnable="True" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="56" Scale9Height="56" ctype="PanelObjectData">
                <Size X="238.0000" Y="210.0000" />
                <Children>
                  <AbstractNodeData Name="box_inside" CanEdit="False" ActionTag="-917971133" Tag="69" IconVisible="False" Scale9Enable="True" LeftEage="18" RightEage="18" TopEage="18" BottomEage="18" Scale9OriginX="18" Scale9OriginY="18" Scale9Width="202" Scale9Height="174" ctype="ImageViewObjectData">
                    <Size X="238.0000" Y="210.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="119.0000" Y="105.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.5000" />
                    <PreSize X="1.0000" Y="1.0000" />
                    <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/FirstCharge_Img/Firstcharge_ItemsBG1.png" Plist="hallcocosstudio/images/plist/FirstCharge_Img.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="item_1" ActionTag="-1072466723" Tag="70" IconVisible="False" LeftMargin="30.1756" RightMargin="32.8244" TopMargin="13.3820" BottomMargin="19.6180" Scale9Width="175" Scale9Height="177" ctype="ImageViewObjectData">
                    <Size X="175.0000" Y="177.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="117.6756" Y="108.1180" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.4944" Y="0.5148" />
                    <PreSize X="0.7353" Y="0.8429" />
                    <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/FirstCharge_Img/FirstCharge_Item1.png" Plist="hallcocosstudio/images/plist/FirstCharge_Img.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="img_box_bg" ActionTag="-147174569" Tag="52" IconVisible="False" LeftMargin="6.0000" RightMargin="-4.0000" TopMargin="127.0000" BottomMargin="11.0000" Scale9Width="236" Scale9Height="72" ctype="ImageViewObjectData">
                    <Size X="236.0000" Y="72.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="124.0000" Y="47.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5210" Y="0.2238" />
                    <PreSize X="0.9916" Y="0.3429" />
                    <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/FirstCharge_Img/Firstcharge_ItemRewardBG1.png" Plist="hallcocosstudio/images/plist/FirstCharge_Img.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="item_num_1" ActionTag="-1880122364" Tag="58" Rotation="-6.0002" RotationSkewX="-6.0002" RotationSkewY="-5.9997" IconVisible="False" LeftMargin="14.7820" RightMargin="11.2180" TopMargin="158.5228" BottomMargin="11.4772" LabelText="获得10000银子" ctype="TextBMFontObjectData">
                    <Size X="212.0000" Y="40.0000" />
                    <AnchorPoint ScaleY="0.5000" />
                    <Position X="14.7820" Y="31.4772" />
                    <Scale ScaleX="0.9000" ScaleY="0.9000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.0621" Y="0.1499" />
                    <PreSize X="0.0798" Y="0.1905" />
                    <LabelBMFontFile_CNB Type="Normal" Path="hallcocosstudio/images/font/shop_firstcharge_detail.fnt" Plist="" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="55.7369" Y="124.0001" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.0846" Y="0.2805" />
                <PreSize X="0.3612" Y="0.4751" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Panel_item_2" ActionTag="1065638982" Tag="82" IconVisible="False" LeftMargin="402.9110" RightMargin="73.0890" TopMargin="107.9999" BottomMargin="124.0001" TouchEnable="True" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="148" Scale9Height="172" ctype="PanelObjectData">
                <Size X="183.0000" Y="210.0000" />
                <Children>
                  <AbstractNodeData Name="box_inside" CanEdit="False" ActionTag="1656751662" Tag="83" IconVisible="False" StretchWidthEnable="True" Scale9Enable="True" LeftEage="18" RightEage="18" TopEage="18" BottomEage="18" Scale9OriginX="18" Scale9OriginY="18" Scale9Width="147" Scale9Height="174" ctype="ImageViewObjectData">
                    <Size X="183.0000" Y="210.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="91.5000" Y="105.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.5000" />
                    <PreSize X="1.0000" Y="1.0000" />
                    <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/FirstCharge_Img/Firstcharge_ItemsBG2.png" Plist="hallcocosstudio/images/plist/FirstCharge_Img.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="item_2" CanEdit="False" ActionTag="2106705042" Tag="84" IconVisible="False" LeftMargin="15.3097" RightMargin="19.6903" TopMargin="17.7726" BottomMargin="20.2274" Scale9Width="148" Scale9Height="172" ctype="ImageViewObjectData">
                    <Size X="148.0000" Y="172.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="89.3097" Y="106.2274" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.4880" Y="0.5058" />
                    <PreSize X="0.8087" Y="0.8190" />
                    <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/FirstCharge_Img/FirstCharge_Item2.png" Plist="hallcocosstudio/images/plist/FirstCharge_Img.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="img_box_bg" ActionTag="-683770816" Tag="54" IconVisible="False" LeftMargin="5.5003" RightMargin="-15.5003" TopMargin="131.5000" BottomMargin="9.5000" Scale9Width="193" Scale9Height="69" ctype="ImageViewObjectData">
                    <Size X="193.0000" Y="69.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="102.0003" Y="44.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5574" Y="0.2095" />
                    <PreSize X="1.0546" Y="0.3286" />
                    <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/FirstCharge_Img/Firstcharge_ItemRewardBG2.png" Plist="hallcocosstudio/images/plist/FirstCharge_Img.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="text_tab_present_3" ActionTag="1534558269" Tag="57" IconVisible="False" LeftMargin="-32.2164" RightMargin="110.2164" TopMargin="-21.9682" BottomMargin="130.9682" ctype="SpriteObjectData">
                    <Size X="105.0000" Y="101.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="20.2836" Y="181.4682" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.1108" Y="0.8641" />
                    <PreSize />
                    <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/FirstCharge_Img/FirstCharge_Tag.png" Plist="hallcocosstudio/images/plist/FirstCharge_Img.plist" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="item_num_2" ActionTag="-200103345" Tag="59" Rotation="-6.0002" RotationSkewX="-6.0002" RotationSkewY="-5.9999" IconVisible="False" LeftMargin="6.3254" RightMargin="-3.3254" TopMargin="150.6767" BottomMargin="19.3233" LabelText="送10000银子" ctype="TextBMFontObjectData">
                    <Size X="180.0000" Y="40.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="96.3254" Y="39.3233" />
                    <Scale ScaleX="0.9000" ScaleY="0.9000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5264" Y="0.1873" />
                    <PreSize X="0.1038" Y="0.1905" />
                    <LabelBMFontFile_CNB Type="Normal" Path="hallcocosstudio/images/font/shop_firstcharge_detail.fnt" Plist="" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="402.9110" Y="124.0001" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.6114" Y="0.2805" />
                <PreSize X="0.2777" Y="0.4751" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_cancel" ActionTag="-1385170036" Tag="21" IconVisible="False" LeftMargin="586.6074" RightMargin="-6.6074" TopMargin="-40.9630" BottomMargin="406.9630" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="49" Scale9Height="54" OutlineSize="0" ShadowOffsetX="0" ShadowOffsetY="0" ctype="ButtonObjectData">
                <Size X="79.0000" Y="76.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="626.1074" Y="444.9630" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.9501" Y="1.0067" />
                <PreSize X="0.1199" Y="0.1719" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/Common/Hall_Btn_Close.png" Plist="hallcocosstudio/images/plist/Common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="255" G="127" B="80" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
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