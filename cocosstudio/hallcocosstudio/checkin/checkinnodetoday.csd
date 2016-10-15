<GameProjectFile>
  <PropertyGroup Type="Node" Name="CheckinNodeToday" ID="c8eef422-32d1-472b-8b32-6d217fbc8bc9" Version="2.3.0.1" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="100" Speed="0.3333">
        <Timeline ActionTag="1327875955" Property="Alpha">
          <IntFrame FrameIndex="0" Value="0">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="40" Value="255">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="50" Value="255">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="100" Value="0">
            <EasingData Type="0" />
          </IntFrame>
        </Timeline>
      </Animation>
      <AnimationList>
        <AnimationInfo Name="animationLight" StartIndex="101" EndIndex="110">
          <RenderColor A="255" R="210" G="105" B="30" />
        </AnimationInfo>
        <AnimationInfo Name="animationBackGroundLight" StartIndex="0" EndIndex="100">
          <RenderColor A="255" R="205" G="92" B="92" />
        </AnimationInfo>
      </AnimationList>
      <ObjectData Name="Node" Tag="319" ctype="GameNodeObjectData">
        <Size />
        <Children>
          <AbstractNodeData Name="Btn_CheckInMain" ActionTag="-1451918273" Tag="322" IconVisible="False" LeftMargin="-86.0000" RightMargin="-86.0000" TopMargin="-104.5000" BottomMargin="-104.5000" TouchEnable="True" FontSize="14" Scale9Enable="True" Scale9Width="172" Scale9Height="209" OutlineSize="0" ShadowOffsetX="0" ShadowOffsetY="0" ctype="ButtonObjectData">
            <Size X="172.0000" Y="209.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <TextColor A="255" R="65" G="65" B="70" />
            <PressedFileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/CheckIn_Img/CheckInUnitBG_L.png" Plist="hallcocosstudio/images/plist/CheckIn_Img.plist" />
            <NormalFileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/CheckIn_Img/CheckInUnitBG_L.png" Plist="hallcocosstudio/images/plist/CheckIn_Img.plist" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="255" G="127" B="80" />
          </AbstractNodeData>
          <AbstractNodeData Name="Img_Light" ActionTag="1327875955" Tag="417" Alpha="0" IconVisible="False" LeftMargin="-90.7965" RightMargin="-91.2035" TopMargin="-113.1901" BottomMargin="-105.8099" Scale9Width="182" Scale9Height="219" ctype="ImageViewObjectData">
            <Size X="182.0000" Y="219.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="0.2035" Y="3.6901" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/CheckIn_Img/CheckInUnitLight.png" Plist="hallcocosstudio/images/plist/CheckIn_Img.plist" />
          </AbstractNodeData>
          <AbstractNodeData Name="Img_DayBG" ActionTag="1402511714" Tag="2363" IconVisible="False" LeftMargin="-55.5000" RightMargin="-55.5000" TopMargin="-162.0000" BottomMargin="118.0000" Scale9Width="111" Scale9Height="44" ctype="ImageViewObjectData">
            <Size X="111.0000" Y="44.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position Y="140.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/CheckIn_Img/CheckinDayBG_L.png" Plist="hallcocosstudio/images/plist/CheckIn_Img.plist" />
          </AbstractNodeData>
          <AbstractNodeData Name="Text_Day" ActionTag="2112412660" Tag="2364" IconVisible="False" LeftMargin="-30.0000" RightMargin="-30.0000" TopMargin="-150.0001" BottomMargin="130.0001" FontSize="20" LabelText="第%d天" OutlineSize="0" ShadowOffsetX="0" ShadowOffsetY="0" ctype="TextObjectData">
            <Size X="60.0000" Y="20.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position Y="140.0001" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="153" G="61" B="54" />
            <PrePosition />
            <PreSize />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="255" G="127" B="80" />
          </AbstractNodeData>
          <AbstractNodeData Name="Img_Deposit_1" ActionTag="1667087660" Tag="48" VisibleForFrame="False" IconVisible="False" LeftMargin="-86.0000" RightMargin="-86.0000" TopMargin="-104.5000" BottomMargin="-104.5000" Scale9Width="172" Scale9Height="209" ctype="ImageViewObjectData">
            <Size X="172.0000" Y="209.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/CheckIn_IconDeposit/CheckIn_Deposit1_L.png" Plist="hallcocosstudio/images/plist/CheckIn_IconDeposit.plist" />
          </AbstractNodeData>
          <AbstractNodeData Name="Img_Deposit_2" ActionTag="1347169442" Tag="166" VisibleForFrame="False" IconVisible="False" LeftMargin="-86.0000" RightMargin="-86.0000" TopMargin="-104.5000" BottomMargin="-104.5000" Scale9Width="172" Scale9Height="209" ctype="ImageViewObjectData">
            <Size X="172.0000" Y="209.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/CheckIn_IconDeposit/CheckIn_Deposit2_L.png" Plist="hallcocosstudio/images/plist/CheckIn_IconDeposit.plist" />
          </AbstractNodeData>
          <AbstractNodeData Name="Img_Deposit_3" ActionTag="1397550534" Tag="167" VisibleForFrame="False" IconVisible="False" LeftMargin="-86.0000" RightMargin="-86.0000" TopMargin="-104.5000" BottomMargin="-104.5000" Scale9Width="172" Scale9Height="209" ctype="ImageViewObjectData">
            <Size X="172.0000" Y="209.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/CheckIn_IconDeposit/CheckIn_Deposit3_L.png" Plist="hallcocosstudio/images/plist/CheckIn_IconDeposit.plist" />
          </AbstractNodeData>
          <AbstractNodeData Name="Img_Deposit_4" ActionTag="1442316340" Tag="168" VisibleForFrame="False" IconVisible="False" LeftMargin="-86.0000" RightMargin="-86.0000" TopMargin="-104.5000" BottomMargin="-104.5000" Scale9Width="172" Scale9Height="209" ctype="ImageViewObjectData">
            <Size X="172.0000" Y="209.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/CheckIn_IconDeposit/CheckIn_Deposit4_L.png" Plist="hallcocosstudio/images/plist/CheckIn_IconDeposit.plist" />
          </AbstractNodeData>
          <AbstractNodeData Name="Img_Deposit_5" ActionTag="-1012632013" Tag="169" VisibleForFrame="False" IconVisible="False" LeftMargin="-86.0000" RightMargin="-86.0000" TopMargin="-104.5000" BottomMargin="-104.5000" Scale9Width="172" Scale9Height="209" ctype="ImageViewObjectData">
            <Size X="172.0000" Y="209.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/CheckIn_IconDeposit/CheckIn_Deposit5_L.png" Plist="hallcocosstudio/images/plist/CheckIn_IconDeposit.plist" />
          </AbstractNodeData>
          <AbstractNodeData Name="Img_Score_1" ActionTag="577831233" Tag="52" VisibleForFrame="False" IconVisible="False" LeftMargin="-86.0000" RightMargin="-86.0000" TopMargin="-104.5000" BottomMargin="-104.5000" Scale9Width="172" Scale9Height="209" ctype="ImageViewObjectData">
            <Size X="172.0000" Y="209.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/CheckIn_IconScore/CheckIn_Score1_L.png" Plist="hallcocosstudio/images/plist/CheckIn_IconScore.plist" />
          </AbstractNodeData>
          <AbstractNodeData Name="Img_Score_2" ActionTag="-1359891426" Tag="53" VisibleForFrame="False" IconVisible="False" LeftMargin="-86.0000" RightMargin="-86.0000" TopMargin="-104.5000" BottomMargin="-104.5000" Scale9Width="172" Scale9Height="209" ctype="ImageViewObjectData">
            <Size X="172.0000" Y="209.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/CheckIn_IconScore/CheckIn_Score2_L.png" Plist="hallcocosstudio/images/plist/CheckIn_IconScore.plist" />
          </AbstractNodeData>
          <AbstractNodeData Name="Img_Score_3" ActionTag="1817739956" Tag="54" VisibleForFrame="False" IconVisible="False" LeftMargin="-86.0000" RightMargin="-86.0000" TopMargin="-104.5000" BottomMargin="-104.5000" Scale9Width="172" Scale9Height="209" ctype="ImageViewObjectData">
            <Size X="172.0000" Y="209.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/CheckIn_IconScore/CheckIn_Score3_L.png" Plist="hallcocosstudio/images/plist/CheckIn_IconScore.plist" />
          </AbstractNodeData>
          <AbstractNodeData Name="Img_Score_4" ActionTag="2107302585" Tag="55" VisibleForFrame="False" IconVisible="False" LeftMargin="-86.0000" RightMargin="-86.0000" TopMargin="-104.5000" BottomMargin="-104.5000" Scale9Width="172" Scale9Height="209" ctype="ImageViewObjectData">
            <Size X="172.0000" Y="209.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/CheckIn_IconScore/CheckIn_Score4_L.png" Plist="hallcocosstudio/images/plist/CheckIn_IconScore.plist" />
          </AbstractNodeData>
          <AbstractNodeData Name="Img_Score_5" ActionTag="-243564739" Tag="56" VisibleForFrame="False" IconVisible="False" LeftMargin="-86.0000" RightMargin="-86.0000" TopMargin="-104.5000" BottomMargin="-104.5000" Scale9Width="172" Scale9Height="209" ctype="ImageViewObjectData">
            <Size X="172.0000" Y="209.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/CheckIn_IconScore/CheckIn_Score5_L.png" Plist="hallcocosstudio/images/plist/CheckIn_IconScore.plist" />
          </AbstractNodeData>
          <AbstractNodeData Name="Text_RewardSilver" ActionTag="-521372205" Tag="324" IconVisible="False" LeftMargin="-23.9995" RightMargin="-24.0005" TopMargin="57.9998" BottomMargin="-81.9998" FontSize="24" LabelText="%d两" OutlineSize="0" ShadowOffsetX="0" ShadowOffsetY="0" ctype="TextObjectData">
            <Size X="48.0000" Y="24.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="0.0005" Y="-69.9998" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="249" B="179" />
            <PrePosition />
            <PreSize />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="255" G="127" B="80" />
          </AbstractNodeData>
          <AbstractNodeData Name="Text_RewardScore" ActionTag="-551038933" Tag="49" IconVisible="False" LeftMargin="-24.0000" RightMargin="-24.0000" TopMargin="58.0000" BottomMargin="-82.0000" FontSize="24" LabelText="%d分" OutlineSize="0" ShadowOffsetX="0" ShadowOffsetY="0" ctype="TextObjectData">
            <Size X="48.0000" Y="24.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position Y="-70.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="249" B="179" />
            <PrePosition />
            <PreSize />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="255" G="127" B="80" />
          </AbstractNodeData>
          <AbstractNodeData Name="Img_CheckedTips" ActionTag="149072798" Tag="323" IconVisible="False" LeftMargin="-53.0000" RightMargin="-53.0000" TopMargin="-87.5000" BottomMargin="-47.5000" Scale9Width="106" Scale9Height="135" ctype="ImageViewObjectData">
            <Size X="106.0000" Y="135.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position Y="20.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="MarkedSubImage" Path="hallcocosstudio/images/plist/CheckIn_Img/CheckInAttention_2.png" Plist="hallcocosstudio/images/plist/CheckIn_Img.plist" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameProjectFile>