unit UpdateSnake;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,wininet, StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
   f1,f2:textfile;
   x:integer;
   s,s1,s2:string;
implementation

{$R *.dfm}
 function GetInetFile(const fileURL, FileName: String): boolean;
const BufferSize = 1024;
var hSession, hURL: HInternet;
Buffer: array[1..BufferSize] of Byte;
BufferLen: DWORD;
f: File;
sAppName: string;
begin
   Result:=False;
   sAppName := ExtractFileName(Application.ExeName);
   hSession := InternetOpen(PChar(sAppName), INTERNET_OPEN_TYPE_PRECONFIG,
         nil, nil, 0);
   try
      hURL := InternetOpenURL(hSession,
      PChar(fileURL),nil,0,0,0);
        if hurl<>nil then
      try
         AssignFile(f, FileName);
         Rewrite(f,1);


         repeat
            InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufferLen);
            BlockWrite(f, Buffer, BufferLen)
         until BufferLen = 0;
         CloseFile(f);
         Result:=True;
      finally
      InternetCloseHandle(hURL)
      end
   finally
   InternetCloseHandle(hSession)
   end
end;

 {function FileVersion(AFileName: string): string;
var
  szName: array[0..255] of Char;
  P: Pointer;
  Value: Pointer;
  Len: UINT;
  GetTranslationString: string;
  FFileName: PChar;
  FValid: boolean;
  FSize: DWORD;
  FHandle: DWORD;
  FBuffer: PChar;
begin
  try
    FFileName := StrPCopy(StrAlloc(Length(AFileName) + 1), AFileName);
    FValid := False;
    FSize := GetFileVersionInfoSize(FFileName, FHandle);
    if FSize > 0 then
    try
      GetMem(FBuffer, FSize);
      FValid := GetFileVersionInfo(FFileName, FHandle, FSize, FBuffer);
    except
      FValid := False;
      raise;
    end;
    Result := '';
    if FValid then
      VerQueryValue(FBuffer, '\VarFileInfo\Translation', p, Len)
    else
      p := nil;
    if P <> nil then
      GetTranslationString := IntToHex(MakeLong(HiWord(Longint(P^)),
        LoWord(Longint(P^))), 8);
    if FValid then
    begin
      StrPCopy(szName, '\StringFileInfo\' + GetTranslationString +
        '\FileVersion');
      if VerQueryValue(FBuffer, szName, Value, Len) then
        Result := StrPas(PChar(Value));
    end;
  finally
    try
      if FBuffer <> nil then
        FreeMem(FBuffer, FSize);
    except
    end;
    try
      StrDispose(FFileName);
    except
    end;
  end;
end;
 function InetIsOffline(Flag: Integer): Boolean;
stdcall; external 'URL.DLL';
   }

procedure TForm2.Button1Click(Sender: TObject);
var FileOnNet, LocalFileName: string;
begin

//if InetIsOffline(0) then
 // ShowMessage('This computer is not connected to Internet!')
//else
//  ShowMessage('You are connected to Internet!');

  { FileOnNet:='https://sites.google.com/site/diminiincupdates/snake/Lastversion.txt';
   LocalFileName:='lastversioncheck.txt';
   }
    FileOnNet:='https://sites.google.com/site/diminiincupdates/snake/Snake2.txt';
   LocalFileName:='snakeexefile.exe';
   if GetInetFile(FileOnNet,LocalFileName)=True then
      ShowMessage('Download successful version')
   else
      ShowMessage('Error in file download version');
   //   RenameFile('updatesnake_.exe','uuppss.exe');
     // copyfile( 'c:\Users\yas\Downloads\Snake_v.1.0\License.txt','c:\Users\yas\Downloads\License.txt',false);
//assignfile(f1,'lastversioncheck.txt');
//assignfile(f2,'lastversion.txt');
//reset(f1);
//reset(f2);
//read(f1,s1);
//read(f2,s2);
//  FileVersion(Paramstr(0));
  //s2:=  FileVersion('Snake2.exe');
  x:=getfileversion('snake2.exe');
{if s1<>s2 then
 begin
   FileOnNet:='https://sites.google.com/site/diminiincupdates/snake/Snake_v.1.0.zip';
   LocalFileName:='lastversioncheck.txt';

   if GetInetFile(FileOnNet,LocalFileName)=True then
      ShowMessage('Download successful snake')
   else
      ShowMessage('Error in file download snake');
 end; }

end;

end.
