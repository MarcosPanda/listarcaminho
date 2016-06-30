unit MapeamentoTeste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus,
  Vcl.ComCtrls,StrUtils, System.RegularExpressions;

type
  TComponentes = (cTButton,
                  cTSpeedButton,
                  cTEdit,
                  cTMaskEdit,
                  cTDBEdit,
                  cTDBRichEdit,
                  cTDBText,
                  cTDBMemo,
                  cTDBListBox,
                  cTDBCheckBox,
                  cTDBRadioGroup,
                  cTDBCtrlGrid,
                  cTComboBox,
                  cTDBGrid,
                  cTDBComboBox,
                  cTDBLookupComboBox,
                  cTIncCombo,
                  cTDBIncCombo,
                  cTDBIncLookupCombo,
                  cTDBIncSearchCombo,
                  cTBitBtn,
                  cTMenuItem);
  TForm1 = class(TForm)
    FileOpenDialog1: TFileOpenDialog;
    Memo1: TMemo;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Button1: TButton;
    Panel1: TPanel;
    ListBox1: TListBox;
    Label1: TLabel;
    Button2: TButton;
    PopupMenu1: TPopupMenu;
    Selecionartodos1: TMenuItem;
    ProgressBar1: TProgressBar;
    procedure Button2Click(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Selecionartodos1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    function getEnd(Start: Integer; tBegin, tEnd: String; List: TStrings): Integer;
    procedure ProcessaArq(arq: TStringList);
    function Sanitize(arq: TStringList): TStringList;
    function ProcessaLinha(linha: String; Componente: TComponentes): String;
    function ToString(c: TComponentes): String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.Generics.Collections, System.TypInfo;

{$R *.dfm}

function TForm1.ProcessaLinha(linha: String; Componente: TComponentes): String;
begin
  case Componente of
            cTButton:
            begin
              Result := linha;
            end;
       cTSpeedButton: Result := linha;
              cTEdit: Result := linha;
          cTMaskEdit: Result := linha;
            cTDBEdit: Result := linha;
        cTDBRichEdit: Result := linha;
            cTDBText: Result := linha;
            cTDBMemo: Result := linha;
         cTDBListBox: Result := linha;
        cTDBCheckBox: Result := linha;
      cTDBRadioGroup: Result := linha;
        cTDBCtrlGrid: Result := linha;
          cTComboBox: Result := linha;
            cTDBGrid: Result := linha;
        cTDBComboBox: Result := linha;
  cTDBLookupComboBox: Result := linha;
          cTIncCombo: Result := linha;
        cTDBIncCombo: Result := linha;
  cTDBIncLookupCombo: Result := linha;
  cTDBIncSearchCombo: Result := linha;
            cTBitBtn: Result := linha;
          CTMenuItem: Result := linha;
    else Result := linha;
  end;
end;

function TForm1.ToString(c: TComponentes): String;
begin
 Result := GetEnumName(TypeInfo(TComponentes),Integer(c)).Substring(1);
end;

procedure TForm1.Button1Click(Sender: TObject);
var arqs: TList<TStringList>;
    arq: TStringList;
    s: String;
begin
  ProgressBar1.Position := 0;
  ProgressBar1.Max := ListBox1.Count;
  ProgressBar1.Step := 1;
  Memo1.Clear;


  arqs := TList<TStringList>.Create;
  if ListBox1.Count > 0  then begin
    for s in ListBox1.Items do begin
      if FileExists(s) then begin
        arq := TStringList.Create;
        arq.LoadFromFile(s);
        arq := Sanitize(arq);
        arqs.Add(arq);
      end;
      ProgressBar1.StepIt;
    end;
  end;

  try
    ProgressBar1.Position := 0;
    ProgressBar1.Max := arqs.Count;
    for arq in arqs do begin
      ProcessaArq(arq);
      ProgressBar1.StepIt;
    end;
  finally
    ShowMessage('Finalizado');
    ProgressBar1.Position := 0;
    arqs.Free;
  end;
end;

function TiraUltima(s:String):String;
var c,
    i: Integer;

begin
  for I := 0 to s.Length - 1 do
    if s[i] = '.' then
      c := i;

  Result := Copy(s,0,c - 1);
end;

procedure TForm1.ProcessaArq(arq: TStringList);
var s,
    st,
    hierarquia,
    linha: String;
    nivel,
    l,f: Integer;
    c: TComponentes;
const tgI = 'object ';
      tgF = ':';

begin
  nivel := 0;
  l := 0;
  for s in arq do begin
    if s.Trim.ToLower.StartsWith(tgI) then begin
      st := Copy(s.Trim,tgI.Length + 1,Pos(tgF,s.Trim) - tgI.Length - 1);
      hierarquia := hierarquia + '.' + st.Trim;
      Inc(nivel);
      f := getEnd(l + 1,tgI,'end',arq);
    end;

    if s.Trim.ToLower.EndsWith('end') then begin
      Dec(nivel);
      f := -1;
      hierarquia := TiraUltima(hierarquia);
    end;

    for c := Low(TComponentes) to High(TComponentes) do begin
      if s.Contains(GetEnumName(TypeInfo(TComponentes),Integer(c)).Substring(1)) then
        Memo1.Lines.Add(processaLinha(hierarquia.Substring(1),c));
    end;
    Inc(l);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if FileOpenDialog1.Execute then begin
    ListBox1.Items.AddStrings(FileOpenDialog1.Files);
  end;
end;

procedure TForm1.ListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var i: Integer;
begin
  if Key = VK_DELETE then begin
    i := ListBox1.ItemIndex;
    ListBox1.DeleteSelected;

    if (i >= 0) and (i < ListBox1.Count) then
      ListBox1.Selected[i] := True;
  end;
end;

procedure TForm1.Selecionartodos1Click(Sender: TObject);
begin
  ListBox1.SelectAll;
end;

function TForm1.Sanitize(arq: TStringList): TStringList;
var s,ss: String;
    ch: WideChar;
    bm,bc: Boolean;

begin
  bm := False;
  bc := False;

  for ch in arq.Text do begin
    bm := (ch = '<') or bm;
    bc := (ch = '{') or bc;

    if not bm and not bc then
      ss := ss + ch;

    if ch = '>' then
      bm := False;

    if ch = '}' then
      bc := False;
  end;
  arq.Text := ss;
  Result := arq;
end;

function TForm1.getEnd(Start: Integer; tBegin, tEnd: String;
  List: TStrings): Integer;
var
  s: String;
  c, lb, I: Integer;
  lp: TStringList;
begin
  c := 1;
  lp := TStringList.Create;
  lp.Text := List.Text;
  tBegin := tBegin.Trim.ToUpper;
  tEnd := tEnd.Trim.ToUpper;

  try
    for I := Start to lp.Count - 1 do
    begin
      s := lp[I].ToUpper.Trim;

      if s.Contains(tBegin) or (s = 'item'.ToUpper.Trim) then
      begin
        lb := c;
        Inc(c);
      end;
      if (s.EndsWith(tEnd)) or
         (s.Contains(' ' + tEnd + ' ')) or
         (s.Contains(' ' + tEnd + '>')) then
        Dec(c);
      if c <= 0 then
      begin
        Result := I;
        Exit;
      end;
    end;
  finally
    lp.Free;
  end;
end;
end.
