# SAC Runtime

SAC Runtime (Semantic Atmosphere Core Runtime) é um runtime independente baseado em Liquidsoap 2.x.

## Objetivos

- semantic radio
- atmospheric automix
- DSP modular
- resolvers inteligentes
- MIR/Qdrant
- runtime experimental

## Arquitetura

```text
LibreTime Stack
 ├── Liquidsoap 1.4.x
 ├── Icecast
 └── Rádio principal

SAC Runtime Stack
 ├── Liquidsoap 2.x
 ├── Resolver Engine
 ├── DSP Runtime
 ├── Semantic Runtime
 └── Streams experimentais
```

O SAC Runtime utiliza o mesmo Icecast do LibreTime.
