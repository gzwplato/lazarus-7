unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Image1: TImage;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure reset();
    procedure output();
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  input: integer;
  banknotes: array[1..7,1..2] of integer;
  outputStr: string;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
begin

  reset();
  output();

end;

procedure TForm1.Button1Click(Sender: TObject);
var i, t, input:integer;
begin
   outputStr:='_';
   input:=strtoint(edit1.text);

  if input mod 5 <> 0 then
      showmessage('The ATM outputs only banknotes.')
  else begin
   Image1.canvas.TextOut(200,15,'input: '+inttostr(input)+'     ');
   while input > 0 do begin
       for i:=1 to 7 do begin
       if banknotes[i,1] > 0 then begin
          t := input div banknotes[i,2];
          //showmessage(inttostr(t)); //mazat
          banknotes[i,1] := banknotes[i,1] - t;
          while input >= banknotes[i,2] do
             input := input - banknotes[i,2];
          outputStr:=outputStr+' and ' +inttostr(t)+ ' times '+inttostr(banknotes[i,2]+' ');
       end;
         output();
       end;
   end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    reset();
    output();
end;

procedure TForm1.reset();
var i:integer;
begin
   for i:=1 to 7 do
      banknotes[i,1]:=20;
   banknotes[1,2]:=500;
   banknotes[2,2]:=200;
   banknotes[3,2]:=100;
   banknotes[4,2]:=50;
   banknotes[5,2]:=20;
   banknotes[6,2]:=10;
   banknotes[7,2]:=5;
   outputStr:='';
end;

procedure TForm1.output();
var i:integer;
begin
  for i:=1 to 7 do begin
      Image1.canvas.textout(5,20*i,inttostr(banknotes[i,2])+': '+inttostr(banknotes[i,1])+'   ');
      Image1.canvas.TextOut(100,20*i,'output: '+inttostr(20-banknotes[i,1])+'   ');

  end;
  Image1.canvas.TextOut(5,180,outputStr);

end;

end.

