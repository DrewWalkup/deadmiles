-- premake5.lua
workspace "deadmiles"
   configurations { "Debug", "Release" }
   startproject "deadmiles"

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

group "Dependencies"
   include "vendor/glfw"
   include "vendor/glad"
group ""

project "deadmiles"
   kind "ConsoleApp"
   language "C++"
   targetdir ("bin/" .. outputdir .. "/%{prj.name}")
   objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

   files { "src/**.h", "src/**.cpp" }

   includedirs {
      "vendor/glfw/include",
      "vendor/glad/include"
   }

   links {
      "GLFW",
      "GLAD"
   }

	defines {
		"GLFW_INCLUDE_NONE"
	}

   filter "system:windows"
      systemversion "latest"
      
      links {
         "OpenGL32"
      }

   filter "system:macosx"
      links {
         "Cocoa.framework",
         "OpenGL.framework",
         "IOKit.framework",
         "CoreVideo.framework"
      }

   filter "configurations:Debug"
      defines { "DEBUG" }
      symbols "On"

   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"