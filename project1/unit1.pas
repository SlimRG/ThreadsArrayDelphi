unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

  TR2SThread = class(TThread)
  public
    radius: INTEGER;
    index: INTEGER;
  protected
    procedure Execute; override;
  end;


var
  Form1: TForm1;
  result: array of Double;
implementation

{$R *.lfm}

{ TForm1 }

procedure TR2SThread.Execute();
var
  S : Double;
begin
  S := pi * radius * radius;
  result[index] := S;
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  r1, r2 : INTEGER;
  count : INTEGER;
  R2SThread: array of TR2SThread;
  i : INTEGER;
begin

  r1:= StrToInt(Form1.Edit1.Text);
  r2:= StrToInt(Form1.Edit2.Text);

  count := (r2 - r1);

  SetLength(R2SThread, count);
  SetLength(result, count);

  for i := 0 to count do
  begin
       R2SThread[i] := TR2SThread.Create(True);
       R2SThread[i].radius:= r1 + i;
       R2SThread[i].index:= i;
       R2SThread[i].FreeOnTerminate:=false;
       R2SThread[i].Resume;
  end;

  for i := 0 to count do
  begin
       R2SThread[i].WaitFor;
	   R2SThread[i].Free;   
       Form1.Memo1.Lines.Add(FloatToStr(result[i]));
  end;



end;

end.



