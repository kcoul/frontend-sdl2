add_library(Poco::Util SHARED IMPORTED)

message("${CMAKE_CURRENT_SOURCE_DIR}/libs/poco/iOS-arm64/libPocoUtil.dylib")

set_property(TARGET Poco::Util PROPERTY
        IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/libs/poco/iOS-arm64/libPocoUtil.dylib")

add_library(Poco::Foundation SHARED IMPORTED)

message("${CMAKE_CURRENT_SOURCE_DIR}/libs/poco/iOS-arm64/libPocoFoundation.dylib")

set_property(TARGET Poco::Foundation PROPERTY
        IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/libs/poco/iOS-arm64/libPocoFoundation.dylib")