object MainForm: TMainForm
  Left = 262
  Top = 135
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Send UDP'
  ClientHeight = 194
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00CCC0
    000CCCC0000000000CCCC7777CCCCCCC0000CCCC00000000CCCC7777CCCCCCCC
    C0000CCCCCCCCCCCCCC7777CCCCC0CCCCC0000CCCCCCCCCCCC7777CCCCC700CC
    C00CCCC0000000000CCCC77CCC77000C0000CCCC00000000CCCC7777C7770000
    00000CCCC000000CCCC777777777C000C00000CCCC0000CCCC77777C777CCC00
    CC00000CCCCCCCCCC77777CC77CCCCC0CCC000CCCCC00CCCCC777CCC7CCCCCCC
    CCCC0CCCCCCCCCCCCCC7CCCCCCCCCCCC0CCCCCCCCCCCCCCCCCCCCCC7CCC70CCC
    00CCCCCCCC0CC0CCCCCCCC77CC7700CC000CCCCCC000000CCCCCC777CC7700CC
    0000CCCC00000000CCCC7777CC7700CC0000C0CCC000000CCC7C7777CC7700CC
    0000C0CCC000000CCC7C7777CC7700CC0000CCCC00000000CCCC7777CC7700CC
    000CCCCCC000000CCCCCC777CC7700CC00CCCCCCCC0CC0CCCCCCCC77CC770CCC
    0CCCCCCCCCCCCCCCCCCCCCC7CCC7CCCCCCCC0CCCCCCCCCCCCCC7CCCCCCCCCCC0
    CCC000CCCCC00CCCCC777CCC7CCCCC00CC00000CCCCCCCCCC77777CC77CCC000
    C00000CCCC0000CCCC77777C777C000000000CCCC000000CCCC777777777000C
    0000CCCC00000000CCCC7777C77700CCC00CCCC0000000000CCCC77CCC770CCC
    CC0000CCCCCCCCCCCC7777CCCCC7CCCCC0000CCCCCCCCCCCCCC7777CCCCCCCCC
    0000CCCC00000000CCCC7777CCCCCCC0000CCCC0000000000CCCC7777CCC0000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 16
  object OpenBtn: TButton
    Left = 8
    Top = 56
    Width = 105
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = OpenBtnClick
  end
  object FileEdit: TLabeledEdit
    Left = 8
    Top = 24
    Width = 337
    Height = 24
    EditLabel.Width = 118
    EditLabel.Height = 16
    EditLabel.Caption = #1060#1072#1081#1083' '#1082' '#1086#1090#1087#1088#1072#1074#1082#1077':'
    TabOrder = 1
  end
  object SendBtn: TButton
    Left = 240
    Top = 56
    Width = 105
    Height = 25
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
    TabOrder = 2
    OnClick = SendBtnClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 96
    Width = 337
    Height = 89
    Caption = ' '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1077#1088#1077#1076#1072#1095#1080' '#1092#1072#1081#1083#1072' '
    TabOrder = 3
    object SizeCap: TLabel
      Left = 10
      Top = 20
      Width = 104
      Height = 16
      Caption = #1056#1072#1079#1084#1077#1088' '#1092#1072#1081#1083#1072':'
    end
    object BufCount: TLabel
      Left = 10
      Top = 39
      Width = 151
      Height = 16
      Caption = #1050#1086#1083#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1072#1082#1077#1090#1086#1074':'
    end
    object StatusLabel: TLabel
      Left = 7
      Top = 65
      Width = 18
      Height = 16
      Caption = '      '
    end
    object SizeLabel: TLabel
      Left = 122
      Top = 21
      Width = 7
      Height = 16
      Caption = '0'
    end
    object BufLabel: TLabel
      Left = 166
      Top = 39
      Width = 7
      Height = 16
      Caption = '0'
    end
    object ProgressBar: TProgressBar
      Left = 8
      Top = 64
      Width = 321
      Height = 17
      TabOrder = 0
    end
  end
  object UDPServer: TIdUDPServer
    Active = True
    BufferSize = 40000
    Bindings = <>
    DefaultPort = 1151
    OnUDPRead = UDPServerUDPRead
    Left = 213
    Top = 128
  end
  object OpenDialog: TOpenDialog
    Filter = 'All files (*.*)|*.*'
    Left = 160
    Top = 56
  end
  object UDPClient: TIdUDPServer
    Active = True
    BufferSize = 40000
    Bindings = <>
    DefaultPort = 1152
    OnUDPRead = UDPClientUDPRead
    Left = 251
    Top = 128
  end
  object SaveDialog: TSaveDialog
    Filter = 'All files (*.*)|*.*'
    Left = 125
    Top = 56
  end
end
