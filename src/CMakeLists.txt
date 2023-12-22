
set(PROJECTM_CONFIGURATION_FILE "${CMAKE_CURRENT_BINARY_DIR}/projectMSDL.properties")
set(PROJECTM_CONFIGURATION_FILE "${PROJECTM_CONFIGURATION_FILE}" PARENT_SCOPE)
configure_file(resources/projectMSDL.properties.in "${PROJECTM_CONFIGURATION_FILE}" @ONLY)

add_executable(projectMSDL WIN32
        AudioCapture.cpp
        AudioCapture.h
        FPSLimiter.cpp
        FPSLimiter.h
        main.cpp
        ProjectMSDLApplication.cpp
        ProjectMSDLApplication.h
        ProjectMWrapper.cpp
        ProjectMWrapper.h
        RenderLoop.cpp
        RenderLoop.h
        SDLRenderingWindow.h
        SDLRenderingWindow.cpp
        )

if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    target_sources(projectMSDL
            PRIVATE
            AudioCaptureImpl_WASAPI.h
            AudioCaptureImpl_WASAPI.cpp
            )
    target_compile_definitions(projectMSDL
            PRIVATE
            AUDIO_IMPL_HEADER="AudioCaptureImpl_WASAPI.h"
            )
else()
    target_sources(projectMSDL
            PRIVATE
            AudioCaptureImpl_SDL.h
            AudioCaptureImpl_SDL.cpp
            )
    target_compile_definitions(projectMSDL
            PRIVATE
            AUDIO_IMPL_HEADER="AudioCaptureImpl_SDL.h"
            )
endif()

target_compile_definitions(projectMSDL
        PRIVATE
        PROJECTMSDL_VERSION="${PROJECT_VERSION}"
        )

if (CMAKE_SYSTEM_NAME STREQUAL "iOS")
    target_include_directories(projectMSDL PUBLIC
            "${CMAKE_SOURCE_DIR}/libs/SDL2/include"
            "${CMAKE_SOURCE_DIR}/libs/Poco/Foundation/include"
            "${CMAKE_SOURCE_DIR}/libs/Poco/Util/include"
            "${CMAKE_SOURCE_DIR}/libs/projectM4/include"
            "${CMAKE_SOURCE_DIR}/libs/projectM4-playlist/include"
    )
    set_xcode_property(projectMSDL PRODUCT_BUNDLE_IDENTIFIER "com.kcoul.projectM" All)

    set_target_properties(projectMSDL PROPERTIES
            MACOSX_BUNDLE_GUI_IDENTIFIER "com.kcoul.projectM"
            MACOSX_BUNDLE_BUNDLE_VERSION "1.0.0"
            MACOSX_BUNDLE_SHORT_VERSION_STRING "1.0.0"
            MACOSX_BUNDLE_BUNDLE_NAME "projectM-SDL2")

    set_target_properties(projectMSDL PROPERTIES
            INSTALL_RPATH "@executable_path/Frameworks")

    set_target_properties(projectMSDL PROPERTIES
            XCODE_ATTRIBUTE_LD_RUNPATH_SEARCH_PATHS "@executable_path/Frameworks")

    set(PROJECTM_DIR "${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4/iOS-arm64/Release-iphoneos/")
    list(APPEND projectm_libs
            "${PROJECTM_DIR}/libprojectM-4.dylib"
            "${PROJECTM_DIR}/libprojectM-4.4.dylib"
            "${PROJECTM_DIR}/libprojectM-4.4.0.0.dylib"
    )

    set(PROJECTM_PLAYLIST_DIR "${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4-playlist/iOS-arm64/Release-iphoneos/")
    list(APPEND projectm_playlist_libs
            "${PROJECTM_DIR}/libprojectM-4-playlist.dylib"
            "${PROJECTM_DIR}/libprojectM-4-playlist.4.dylib"
            "${PROJECTM_DIR}/libprojectM-4-playlist.4.0.0.dylib"
    )

    set(POCO_DIR "${CMAKE_CURRENT_SOURCE_DIR}/libs/poco/iOS-arm64/")
    list(APPEND poco_libs
            "${POCO_UTIL_DIR}/libPocoUtil.95.dylib"
            "${POCO_UTIL_DIR}/libPocoUtil.dylib"
            "${POCO_FOUNDATION_DIR}/libPocoFoundation.95.dylib"
            "${POCO_FOUNDATION_DIR}/libPocoFoundation.dylib"
            "${POCO_FOUNDATION_DIR}/libPocoJSON.95.dylib"
            "${POCO_FOUNDATION_DIR}/libPocoJSON.dylib"
            "${POCO_FOUNDATION_DIR}/libPocoXML.95.dylib"
            "${POCO_FOUNDATION_DIR}/libPocoXML.dylib"
    )

    # This sort of thing might not work for the Xcode generator?
    #install(
    #        FILES "${projectm_libs}"
    #        DESTINATION "$<TARGET_BUNDLE_DIR_NAME:${target}>/Contents/Frameworks"
    #)

    #install(
    #        FILES "${projectm_playlist_libs}"
    #        DESTINATION "$<TARGET_BUNDLE_DIR_NAME:${target}>/Contents/Frameworks"
    #)
endif()

target_link_libraries(projectMSDL
        PRIVATE
        libprojectM::projectM
        libprojectM::playlist
        Poco::Util
        Poco::Foundation
        Poco::JSON
        Poco::XML
        SDL2::SDL2
        #SDL2::SDL2main #Shouldn't be necessary on iOS?
        )

if (CMAKE_SYSTEM_NAME STREQUAL "iOS")
    target_link_libraries(projectMSDL
            PRIVATE "-framework OpenGLES
            -framework AVFAudio
            -framework AudioToolbox
            -framework QuartzCore
            -framework CoreGraphics
            -framework CoreHaptics
            -framework CoreMotion
            -framework Foundation
            -framework GameController
            -framework Metal
            -framework UIKit")
endif()

if(MSVC)
    set_target_properties(projectMSDL
            PROPERTIES
            VS_DPI_AWARE "PerMonitor"
            )
endif()
