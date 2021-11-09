object TPrincipal: TTPrincipal
  Left = 0
  Top = 0
  Caption = 'WK ERP'
  ClientHeight = 285
  ClientWidth = 570
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mnuPrincipal
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object mnuPrincipal: TMainMenu
    Left = 128
    Top = 56
    object Arquivo1: TMenuItem
      Caption = '&Cadastros'
      object acPedidos1: TMenuItem
        Action = acPedidos
        Caption = '&Pedidos'
        ShortCut = 16500
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Sair1: TMenuItem
        Caption = 'Sai&r'
      end
    end
  end
  object actPrincipal: TActionList
    Left = 224
    Top = 56
    object acPedidos: TAction
      Category = 'Cadastros'
      Caption = 'acPedidos'
      OnExecute = acPedidosExecute
    end
  end
end
