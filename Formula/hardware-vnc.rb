class HardwareVnc < Formula
  desc "Hardware-based VNC Server for VMs that use Physical GPU"
  homepage "https://github.com/WhirlwindOfLight/HardwareVNC"
  url "https://github.com/WhirlwindOfLight/HardwareVNC/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "c00cc8cee0b4bda6ba14e98702d2e4a51de96db04fd647dee9ab5511a9c14029"
  license "GPL-3.0-only"
  head "https://github.com/WhirlwindOfLight/HardwareVNC.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "libvncserver"
  depends_on "opencv"
  depends_on "yaml-cpp"

  BIN_NAME = "hardware-vnc".freeze

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # Proves the file is there
    assert_path_exists bin/BIN_NAME

    # Proves the file is executable
    assert_predicate bin/BIN_NAME, :executable?
  end

  service do
    run opt_bin/BIN_NAME
    keep_alive crashed: true
  end
end
