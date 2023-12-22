
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
            MACOSX_BUNDLE_BUNDLE_NAME "projectM-SDL2"
            MACOSX_BUNDLE_INFO_PLIST ${CMAKE_SOURCE_DIR}/src/Info.plist)

    set_target_properties(projectMSDL PROPERTIES
            XCODE_ATTRIBUTE_LD_RUNPATH_SEARCH_PATHS "@executable_path/Frameworks")

    set(PROJECTM_DIR "${CMAKE_SOURCE_DIR}/libs/projectM4/iOS-arm64/Release-iphoneos")
    set(PROJECTM_PLAYLIST_DIR "${CMAKE_SOURCE_DIR}/libs/projectM4-playlist/iOS-arm64/Release-iphoneos")
    set(POCO_DIR "${CMAKE_SOURCE_DIR}/libs/Poco/iOS-arm64")

    set(RESOURCE_FILES
            "${CMAKE_SOURCE_DIR}/resources/Presets/oscilloscope/flagoscope/flagoscope3.milk"
            "${CMAKE_SOURCE_DIR}/resources/Presets/oscilloscope/flagoscope/flagoscope4.milk"
            "${CMAKE_SOURCE_DIR}/resources/Presets/oscilloscope/ondulloscope/amandioc-ondulloscope.milk"
            "${CMAKE_SOURCE_DIR}/resources/Presets/oscilloscope/ondulloscope/amandioc-ondulloscope2.milk"
            "${CMAKE_SOURCE_DIR}/resources/Presets/oscilloscope/ondulloscope/amandioc-ondulloscope2a.milk")

    target_sources(projectMSDL PRIVATE ${RESOURCE_FILES})
    set_source_files_properties(${RESOURCE_FILES} PROPERTIES
            MACOSX_PACKAGE_LOCATION "Resources"
    )
    source_group("Resources" FILES ${RESOURCE_FILES})

    # Pretty insane there's no better way to do this...?
    # https://www.gbgames.com/2022/08/08/freshly-squeezed-progress-report-mac-port-automation-finished-and-60-fps-fest/
    set_target_properties(projectMSDL PROPERTIES
            MACOSX_BUNDLE TRUE
            INSTALL_RPATH "@executable_path/Frameworks"
            XCODE_EMBED_FRAMEWORKS "${PROJECTM_DIR}/libprojectM-4.dylib;${PROJECTM_DIR}/libprojectM-4.4.dylib;${PROJECTM_DIR}/libprojectM-4.4.0.0.dylib;${PROJECTM_PLAYLIST_DIR}/libprojectM-4-playlist.dylib;${PROJECTM_PLAYLIST_DIR}/libprojectM-4-playlist.4.dylib;${PROJECTM_PLAYLIST_DIR}/libprojectM-4-playlist.4.0.0.dylib;${POCO_DIR}/libPocoUtil.95.dylib;${POCO_DIR}/libPocoUtil.dylib;${POCO_DIR}/libPocoFoundation.95.dylib;${POCO_DIR}/libPocoFoundation.dylib;${POCO_DIR}/libPocoJSON.95.dylib;${POCO_DIR}/libPocoJSON.dylib;${POCO_DIR}/libPocoXML.95.dylib;${POCO_DIR}/libPocoXML.dylib"
            XCODE_EMBED_FRAMEWORKS_CODE_SIGN_ON_COPY FALSE
            XCODE_EMBED_FRAMEWORKS_REMOVE_HEADERS_ON_COPY FALSE)

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
