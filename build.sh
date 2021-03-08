!/bin/bash

export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_NDK_ROOT=$HOME/Android/android-ndk-r21e
export ANDROID_NDK_HOME=$HOME/Android/android-ndk-r21e
export JAVA_HOME=$HOME/jdk-8u282-ojdkbuild-linux-x64

#curl -LO https://curl.haxx.se/ca/cacert.pem
#cert-sync --user cacert.pem

#Linux
# Build temporary binary
scons p=x11 -j16 tools=yes module_mono_enabled=yes mono_glue=no copy_mono_root=yes mono_prefix="$HOME/mono-installs/desktop-linux-x86_64-release"
# Generate glue sources
bin/godot.x11.tools.64.mono --generate-mono-glue modules/mono/glue
### Build binaries normally
# Editor
scons p=x11 -j16 target=release_debug tools=yes module_mono_enabled=yes mono_static=yes copy_mono_root=yes mono_prefix="$HOME/mono-installs/desktop-linux-x86_64-release"
# Export templates
scons p=x11 -j16 target=release_debug tools=no module_mono_enabled=yes mono_static=yes copy_mono_root=yes mono_prefix="$HOME/mono-installs/desktop-linux-x86_64-release"
scons p=x11 -j16 target=release tools=no module_mono_enabled=yes mono_static=yes copy_mono_root=yes mono_prefix="$HOME/mono-installs/desktop-linux-x86_64-release"

#Android
#release
scons platform=android -j16 target=release android_arch=armv7 module_mono_enabled=yes copy_mono_root=yes mono_prefix="$HOME/mono-installs/android-armeabi-v7a-release"
scons platform=android -j16 target=release android_arch=arm64v8 module_mono_enabled=yes copy_mono_root=yes mono_prefix="$HOME/mono-installs/android-arm64-v8a-release"
scons platform=android -j16 target=release android_arch=x86 module_mono_enabled=yes copy_mono_root=yes mono_prefix="$HOME/mono-installs/android-x86-release"
scons platform=android -j16 target=release android_arch=x86_64 module_mono_enabled=yes copy_mono_root=yes mono_prefix="$HOME/mono-installs/android-x86_64-release"
#debug
scons platform=android -j16 target=release_debug android_arch=armv7 module_mono_enabled=yes copy_mono_root=yes mono_prefix="$HOME/mono-installs/android-armeabi-v7a-release"
scons platform=android -j16 target=release_debug android_arch=arm64v8 module_mono_enabled=yes copy_mono_root=yes mono_prefix="$HOME/mono-installs/android-arm64-v8a-release"
scons platform=android -j16 target=release_debug android_arch=x86 module_mono_enabled=yes copy_mono_root=yes mono_prefix="$HOME/mono-installs/android-x86-release"
scons platform=android -j16 target=release_debug android_arch=x86_64 module_mono_enabled=yes copy_mono_root=yes mono_prefix="$HOME/mono-installs/android-x86_64-release"
#gentemplates
cd platform/android/java
./gradlew generateGodotTemplates
