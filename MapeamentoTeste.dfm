object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 330
  ClientWidth = 736
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 518
    Top = 3
    Height = 279
    Align = alRight
    ExplicitLeft = 510
    ExplicitTop = -23
    ExplicitHeight = 296
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 0
    Width = 736
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 47
    ExplicitWidth = 283
  end
  object Memo1: TMemo
    Left = 0
    Top = 3
    Width = 518
    Height = 279
    Align = alClient
    HideSelection = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Button1: TButton
    AlignWithMargins = True
    Left = 3
    Top = 285
    Width = 730
    Height = 25
    Align = alBottom
    Caption = 'Processar'
    TabOrder = 1
    OnClick = Button1Click
    ExplicitLeft = 8
    ExplicitTop = 282
  end
  object Panel1: TPanel
    Left = 521
    Top = 3
    Width = 215
    Height = 279
    Align = alRight
    Caption = 'Panel1'
    TabOrder = 2
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 213
      Height = 13
      Align = alTop
      Caption = 'Arquivos'
      ExplicitWidth = 42
    end
    object ListBox1: TListBox
      Left = 1
      Top = 14
      Width = 213
      Height = 239
      Align = alClient
      ItemHeight = 13
      MultiSelect = True
      PopupMenu = PopupMenu1
      Sorted = True
      TabOrder = 0
      OnKeyDown = ListBox1KeyDown
    end
    object Button2: TButton
      Left = 1
      Top = 253
      Width = 213
      Height = 25
      Align = alBottom
      Caption = 'Selecionar Arquivos'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 313
    Width = 736
    Height = 17
    Align = alBottom
    TabOrder = 3
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'DFM'
        FileMask = '*.dfm'
      end>
    Options = [fdoAllowMultiSelect, fdoFileMustExist]
    Left = 497
    Top = 84
  end
  object PopupMenu1: TPopupMenu
    Left = 644
    Top = 70
    object Selecionartodos1: TMenuItem
      Caption = 'Selecionar todos'
      ShortCut = 16449
      OnClick = Selecionartodos1Click
    end
  end
end
