
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
    set_xcode_property(projectMSDL PRODUCT_BUNDLE_IDENTIFIER "com.kcoul.projectM-SDL2" All)
endif()

target_link_libraries(projectMSDL
        PRIVATE
        libprojectM::playlist
        Poco::Util
        Poco::Foundation
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
