; NSIS installer script for 真果鉴 (zhenguojian) Windows build
Unicode True
!include "MUI2.nsh"

!define APP_NAME "真果鉴"
!define APP_EXE "zhenguojian.exe"
!define APP_VERSION "0.2.64"
!define APP_PUBLISHER "guoapp"
!define APP_REGKEY "Software\zhenguojian"
!define APP_UNINSTKEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\zhenguojian"
!define APP_ICON "..\windows\runner\resources\app_icon.ico"

Name "${APP_NAME} ${APP_VERSION}"
OutFile "..\dist\windows\zhenguojian-${APP_VERSION}-windows-x64-setup.exe"
InstallDir "$PROGRAMFILES64\zhenguojian"
InstallDirRegKey HKLM "${APP_REGKEY}" "InstallDir"
RequestExecutionLevel admin
SetCompressor /SOLID lzma

!define MUI_ICON "${APP_ICON}"
!define MUI_UNICON "${APP_ICON}"
!define MUI_ABORTWARNING

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_LANGUAGE "SimpChinese"

Section "Install"
  SetOutPath "$INSTDIR"
  File /r "..\build\windows\x64\runner\Release\*.*"

  CreateDirectory "$SMPROGRAMS\${APP_NAME}"
  CreateShortCut "$SMPROGRAMS\${APP_NAME}\${APP_NAME}.lnk" "$INSTDIR\${APP_EXE}" "" "$INSTDIR\${APP_EXE}" 0
  CreateShortCut "$SMPROGRAMS\${APP_NAME}\卸载${APP_NAME}.lnk" "$INSTDIR\uninstall.exe"
  CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${APP_EXE}" "" "$INSTDIR\${APP_EXE}" 0

  WriteUninstaller "$INSTDIR\uninstall.exe"
  WriteRegStr HKLM "${APP_REGKEY}" "InstallDir" "$INSTDIR"
  WriteRegStr HKLM "${APP_UNINSTKEY}" "DisplayName" "${APP_NAME}"
  WriteRegStr HKLM "${APP_UNINSTKEY}" "DisplayVersion" "${APP_VERSION}"
  WriteRegStr HKLM "${APP_UNINSTKEY}" "Publisher" "${APP_PUBLISHER}"
  WriteRegStr HKLM "${APP_UNINSTKEY}" "DisplayIcon" "$INSTDIR\${APP_EXE}"
  WriteRegStr HKLM "${APP_UNINSTKEY}" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegDWORD HKLM "${APP_UNINSTKEY}" "NoModify" 1
  WriteRegDWORD HKLM "${APP_UNINSTKEY}" "NoRepair" 1
  WriteRegDWORD HKLM "${APP_UNINSTKEY}" "EstimatedSize" 250000
SectionEnd

Section "Uninstall"
  Delete "$DESKTOP\${APP_NAME}.lnk"
  RMDir /r "$SMPROGRAMS\${APP_NAME}"
  RMDir /r "$INSTDIR"
  DeleteRegKey HKLM "${APP_UNINSTKEY}"
  DeleteRegKey HKLM "${APP_REGKEY}"
SectionEnd
