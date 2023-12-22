add_library(libprojectM::projectM SHARED IMPORTED)
add_library(libprojectM::playlist SHARED IMPORTED)

if (CMAKE_SYSTEM_NAME STREQUAL iOS)
    # TODO: Make into Multi-config generator expression
    #message("Using ${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4/iOS-arm64/Release-iphoneos/libprojectM-4.dylib")
    #message("Using ${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4-playlist/iOS-arm64/Release-iphoneos/libprojectM-4-playlist.dylib")

    message("Using ${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4/iOS-arm64/Debug-iphoneos/libprojectM-4d.dylib")
    message("Using ${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4-playlist/iOS-arm64/Debug-iphoneos/libprojectM-4-playlistd.dylib")

    #set_property(TARGET libprojectM::projectM PROPERTY
    #        IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4/iOS-arm64/Release-iphoneos/libprojectM-4.dylib")
    #set_property(TARGET libprojectM::playlist PROPERTY
    #        IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4-playlist/iOS-arm64/Release-iphoneos/libprojectM-4-playlist.dylib")

    set_property(TARGET libprojectM::projectM PROPERTY
            IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4/iOS-arm64/Debug-iphoneos/libprojectM-4d.dylib")
    set_property(TARGET libprojectM::playlist PROPERTY
            IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4-playlist/iOS-arm64/Debug-iphoneos/libprojectM-4-playlistd.dylib")
elseif (CMAKE_SYSTEM_NAME STREQUAL Darwin) #Single-config for now, use side-by-side build locations
    if (CMAKE_BUILD_TYPE STREQUAL Debug)
        set_property(TARGET libprojectM::projectM PROPERTY
                IMPORTED_LOCATION "${CMAKE_SOURCE_DIR}/../projectm/cmake-build-debug/src/libprojectM/libprojectM-4d.dylib")
        set_property(TARGET libprojectM::playlist PROPERTY
                IMPORTED_LOCATION "${CMAKE_SOURCE_DIR}/../projectm/cmake-build-debug/src/playlist/libprojectM-4-playlistd.dylib")
    elseif (CMAKE_BUILD_TYPE STREQUAL Release)
        set_property(TARGET libprojectM::projectM PROPERTY
                IMPORTED_LOCATION "${CMAKE_SOURCE_DIR}/../projectm/cmake-build-release/src/libprojectM/libprojectM-4.dylib")
        set_property(TARGET libprojectM::playlist PROPERTY
                IMPORTED_LOCATION "${CMAKE_SOURCE_DIR}/../projectm/cmake-build-release/src/playlist/libprojectM-4-playlist.dylib")

    endif()
endif()
