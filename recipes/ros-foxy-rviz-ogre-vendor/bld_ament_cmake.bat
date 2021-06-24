:: Generated by vinca http://github.com/ros-forge/vinca.
:: DO NOT EDIT!
setlocal EnableDelayedExpansion

set "PYTHONPATH=%LIBRARY_PREFIX%\lib\site-packages;%SP_DIR%"

:: MSVC is preferred.
set CC=cl.exe
set CXX=cl.exe

rd /s /q build
mkdir build
pushd build

set "CMAKE_GENERATOR=Ninja"

if "%PKG_NAME%" == "ros-foxy-mimick-vendor" (
    set "CMAKE_GENERATOR=Visual Studio %VS_MAJOR% %VS_YEAR%"
)

cmake ^
    -G "%CMAKE_GENERATOR%" ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_SKIP=True ^
    -DPYTHON_EXECUTABLE=%PYTHON% ^
    -DSETUPTOOLS_DEB_LAYOUT=OFF ^
    -DBUILD_SHARED_LIBS=ON ^
    -DBUILD_TESTING=OFF ^
    %SRC_DIR%\%PKG_NAME%\src\work
if errorlevel 1 exit 1

cmake --build . --config Release --target install
if errorlevel 1 exit 1

if "%PKG_NAME%" == "ros-foxy-ros-workspace" (
    :: Copy the [de]activate scripts to %PREFIX%\etc\conda\[de]activate.d.
    :: This will allow them to be run on environment activation.
    for %%F in (activate deactivate) DO (
        if not exist %PREFIX%\etc\conda\%%F.d mkdir %PREFIX%\etc\conda\%%F.d
        copy %RECIPE_DIR%\%%F.bat %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.bat
    )
)
