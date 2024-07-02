{pkgs, inputs, ...}:
{
  imports = [inputs.waveforms.nixosModule.default];
  waveforms = {
    enable = true;
  };
}
