 defmodule Rayex.BundlexProject do
   use Bundlex.Project

   def project() do
     [
       natives: natives(Bundlex.get_target())
     ]
   end

   def natives(_platform) do
     [
       rayex: [
         sources: ["rayex.c"],
         interface: [:nif, :cnode],
         os_deps: [
           raylib: {:pkg_config, "raylib"}
         ],
         preprocessor: Unifex
       ]
     ]
   end
 end
