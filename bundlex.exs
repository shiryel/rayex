 defmodule Rayex.BundlexProject do
   use Bundlex.Project

   def project() do
     [
       natives: natives(Bundlex.platform())
     ]
   end

   def natives(_platform) do
     [
       rayex: [
         sources: ["rayex.c"],
         interface: [:nif, :cnode],
         pkg_configs: ["raylib"],
         preprocessor: Unifex
       ]
     ]
   end
 end
