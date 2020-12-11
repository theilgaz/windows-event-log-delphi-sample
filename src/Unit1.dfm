object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Windows Event Log Sample'
  ClientHeight = 120
  ClientWidth = 215
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 71
    Width = 193
    Height = 34
    Caption = 'Write Log'
    TabOrder = 0
    OnClick = Button1Click
  end
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 8
    Width = 193
    Height = 57
    TabOrder = 1
  end
  object rbLogger: TRadioButton
    Left = 16
    Top = 41
    Width = 169
    Height = 17
    Caption = 'Log with Helper (TLogger)'
    TabOrder = 2
  end
  object rbEventLogger: TRadioButton
    Left = 16
    Top = 18
    Width = 169
    Height = 17
    Caption = 'Log with SvcMgr.TEventLogger'
    Checked = True
    TabOrder = 3
    TabStop = True
  end
end
