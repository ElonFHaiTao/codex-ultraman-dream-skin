using System;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Threading;
using System.Windows.Forms;

[assembly: AssemblyTitle("Codex 奥特曼主题")]
[assembly: AssemblyDescription("Launch Codex with the Ultra Light Guardian theme")]
[assembly: AssemblyCompany("Codex Dream Skin")]
[assembly: AssemblyProduct("Codex Ultra Light Skin")]
[assembly: AssemblyVersion("1.0.0.0")]
[assembly: AssemblyFileVersion("1.0.0.0")]

internal static class CodexUltraLightLauncher
{
  [STAThread]
  private static void Main()
  {
    bool createdNew;
    using (var mutex = new Mutex(false, @"Local\CodexUltraLightSkinLauncher", out createdNew))
    {
      if (!createdNew)
      {
        return;
      }

      try
      {
        var launcherDirectory = AppDomain.CurrentDomain.BaseDirectory.TrimEnd(
          Path.DirectorySeparatorChar,
          Path.AltDirectorySeparatorChar);
        var packageDirectory = Directory.GetParent(launcherDirectory);
        if (packageDirectory == null)
        {
          throw new DirectoryNotFoundException("无法确定奥特曼主题包目录。");
        }

        var launcherScript = Path.Combine(
          packageDirectory.FullName,
          "windows",
          "scripts",
          "one-click-ultra-light.ps1");

        if (!File.Exists(launcherScript))
        {
          throw new FileNotFoundException("找不到奥特曼主题启动脚本，请先完整解压主题包。", launcherScript);
        }

        var powershell = Path.Combine(
          Environment.GetFolderPath(Environment.SpecialFolder.System),
          @"WindowsPowerShell\v1.0\powershell.exe");
        var startInfo = new ProcessStartInfo
        {
          FileName = powershell,
          Arguments = "-NoProfile -NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -File \"" + launcherScript + "\"",
          WorkingDirectory = Path.GetDirectoryName(launcherScript),
          UseShellExecute = false,
          CreateNoWindow = true,
          WindowStyle = ProcessWindowStyle.Hidden
        };

        Process.Start(startInfo);
      }
      catch (Exception error)
      {
        MessageBox.Show(
          error.Message,
          "奥特曼主题启动失败",
          MessageBoxButtons.OK,
          MessageBoxIcon.Error);
      }
    }
  }
}
