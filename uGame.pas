unit uGame;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TfrmGame }

  TfrmGame = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure TileClick(Sender: TObject);
    function CheckForWin(Sender: TObject): boolean;
  private
    { private declarations }
  public
    { public declarations }
  end;

  TTile = record
    chr: char;
    img: TImage;
    shd: integer;
  end;

var
  frmGame: TfrmGame;
  board: array [1..9,1..9] of TTile;
  turn: integer;
  turnImg: TImage;
const
  tileSize = 64; // ideal value 96
implementation

{$R *.lfm}

{ TTile }
{ TfrmGame }

function TfrmGame.CheckForWin(Sender: TObject): boolean;
  var
    x,o: array [1..3,1..3] of boolean;
    i,j: integer;
begin
  for j:= 4 to 6 do
    for i:= 4 to 6 do
      begin
        x[i-3,j-3]:= false;
        o[i-3,j-3]:= false;
        case board[i,j].chr of
          'X': x[i-3,j-3]:= true;
          'O': o[i-3,j-3]:= true;
        end;
      end;
  if o[1,1] then
    ShowMessage('y');
  if (x[1,1] AND x[1,2] AND x[1,3]) OR
     (x[2,1] AND x[2,2] AND x[2,3]) OR
     (x[3,1] AND x[3,2] AND x[3,3]) OR
     (x[1,1] AND x[2,1] AND x[3,1]) OR
     (x[1,2] AND x[2,2] AND x[3,2]) OR
     (x[1,3] AND x[2,3] AND x[3,3]) OR
     (x[1,1] AND x[2,2] AND x[3,3]) OR
     (x[3,1] AND x[1,2] AND x[1,3]) OR
     (x[1,1] AND x[3,2] AND x[2,3]) OR
     (x[3,1] AND x[1,2] AND x[2,3]) OR
     (x[2,1] AND x[3,2] AND x[1,3]) OR
     (x[2,1] AND x[1,2] AND x[3,3]) then
    begin
      ShowMessage('X wins');
      CheckForWin:= true;
    end;
  if (o[1,1] AND o[1,2] AND o[1,3]) OR
     (o[2,1] AND o[2,2] AND o[2,3]) OR
     (o[3,1] AND o[3,2] AND o[3,3]) OR
     (o[1,1] AND o[2,1] AND o[3,1]) OR
     (o[1,2] AND o[2,2] AND o[3,2]) OR
     (o[1,3] AND o[2,3] AND o[3,3]) OR
     (o[1,1] AND o[2,2] AND o[3,3]) OR
     (o[3,1] AND o[1,2] AND o[1,3]) OR
     (o[1,1] AND o[3,2] AND o[2,3]) OR
     (o[3,1] AND o[1,2] AND o[2,3]) OR
     (o[2,1] AND o[3,2] AND o[1,3]) OR
     (o[2,1] AND o[1,2] AND o[3,3]) then
    begin
      ShowMessage('O wins');
      CheckForWin:= true;
    end;


end;

procedure TfrmGame.TileClick(Sender: TObject);
var
  img: TImage;
  i, j: integer;
begin
  img:= Sender as TImage;
  i:= ord(img.Name[1])-64;
  j:= ord(img.Name[2])-64;
  if (board[i,j].chr='N') AND (i in [4..6]) AND (j in [4..6]) then
    if (turn mod 2 = 0) then
      begin
        board[i,j].chr:= 'X';
        board[i,j].img.Picture.LoadFromFile(concat('images/x_',inttostr(board[i,j].shd),'.png'));
        board[i+3,j].chr:= 'X';
        board[i+3,j].img.Picture.LoadFromFile(concat('images/x_',inttostr(board[i+3,j].shd),'.png'));
        board[i-3,j].chr:= 'X';
        board[i-3,j].img.Picture.LoadFromFile(concat('images/x_',inttostr(board[i-3,j].shd),'.png'));
        board[i,j+3].chr:= 'X';
        board[i,j+3].img.Picture.LoadFromFile(concat('images/x_',inttostr(board[i,j+3].shd),'.png'));
        board[i,j-3].chr:= 'X';
        board[i,j-3].img.Picture.LoadFromFile(concat('images/x_',inttostr(board[i,j-3].shd),'.png'));
        board[i+3,j+3].chr:= 'X';
        board[i+3,j+3].img.Picture.LoadFromFile(concat('images/x_',inttostr(board[i+3,j+3].shd),'.png'));
        board[i-3,j-3].chr:= 'X';
        board[i-3,j-3].img.Picture.LoadFromFile(concat('images/x_',inttostr(board[i-3,j-3].shd),'.png'));
        board[i-3,j+3].chr:= 'X';
        board[i-3,j+3].img.Picture.LoadFromFile(concat('images/x_',inttostr(board[i-3,j+3].shd),'.png'));
        board[i+3,j-3].chr:= 'X';
        board[i+3,j-3].img.Picture.LoadFromFile(concat('images/x_',inttostr(board[i+3,j-3].shd),'.png'));
        inc(turn);
      end
    else
      begin
        board[i,j].chr:= 'O';
        board[i,j].img.Picture.LoadFromFile(concat('images/o_',inttostr(board[i,j].shd),'.png'));
        board[i+3,j].chr:= 'O';
        board[i+3,j].img.Picture.LoadFromFile(concat('images/o_',inttostr(board[i+3,j].shd),'.png'));
        board[i-3,j].chr:= 'O';
        board[i-3,j].img.Picture.LoadFromFile(concat('images/o_',inttostr(board[i-3,j].shd),'.png'));
        board[i,j+3].chr:= 'O';
        board[i,j+3].img.Picture.LoadFromFile(concat('images/o_',inttostr(board[i,j+3].shd),'.png'));
        board[i,j-3].chr:= 'O';
        board[i,j-3].img.Picture.LoadFromFile(concat('images/o_',inttostr(board[i,j-3].shd),'.png'));
        board[i+3,j+3].chr:= 'O';
        board[i+3,j+3].img.Picture.LoadFromFile(concat('images/o_',inttostr(board[i+3,j+3].shd),'.png'));
        board[i-3,j-3].chr:= 'O';
        board[i-3,j-3].img.Picture.LoadFromFile(concat('images/o_',inttostr(board[i-3,j-3].shd),'.png'));
        board[i-3,j+3].chr:= 'O';
        board[i-3,j+3].img.Picture.LoadFromFile(concat('images/o_',inttostr(board[i-3,j+3].shd),'.png'));
        board[i+3,j-3].chr:= 'O';
        board[i+3,j-3].img.Picture.LoadFromFile(concat('images/o_',inttostr(board[i+3,j-3].shd),'.png'));
        inc(turn);
      end;
  if turn mod 2 = 0 then
    turnImg.Picture.LoadFromFile('images/x_turn.png')
  else
    turnImg.Picture.LoadFromFile('images/o_turn.png');
  if CheckForWin(nil) then
    begin

    end;
end;

procedure TfrmGame.FormCreate(Sender: TObject);
var
  i,j: integer;
begin
  turn:= 0;
  with frmGame do
    begin
      PixelsPerInch:= 256;
      Width:= tileSize*9;
      Height:= (tileSize*9)+(tileSize div 2);

      //Color:= clWhite;
    end;
  for j:= 1 to 9 do
    for i:= 1 to 9 do
      begin
        board[i,j].img:= TImage.Create(nil);
        with board[i,j].img do
          begin
            Name:= chr(64+i)+chr(64+j);
            Parent:= frmGame;
            Height:= tileSize;
            Width:= tileSize;
            Left:= (i-1)*tileSize;
            Top:= (j-1)*tileSize;
            Stretch:= True;
            if (i mod 2) = (j mod 2) then
              begin
                Picture.LoadFromFile('images/n_3.png');
                board[i,j].shd:= 3;
              end
            else
              begin
                Picture.LoadFromFile('images/n_4.png');
                board[i,j].shd:= 4;
              end;
            OnClick:= @TileClick;
          end;
        board[i,j].chr:= 'N';
      end;
  for j:= 4 to 6 do
    for i:= 4 to 6 do
      with board[i,j].img do
        if not ((i mod 2) = (j mod 2)) then
          begin
            Picture.LoadFromFile('images/n_1.png');
            board[i,j].shd:= 1;
          end
        else
          begin
            Picture.LoadFromFile('images/n_2.png');
            board[i,j].shd:= 2;
          end;
  turnImg:= TImage.Create(nil);
  with turnImg do
    begin
      Parent:= frmGame;
      Stretch:= True;
      Width:= tileSize*2;
      Height:= tileSize div 2;
      Left:= (frmGame.Width-Width) div 2;
      Top:= tileSize*9;
      Picture.LoadFromFile('images/x_turn.png');
    end;
end;

end.

