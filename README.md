# simple_dri3ble

Listagem e cadastro de shots do Dribbble

## Sobre

Este projeto foi desenvolvido durante teste técnico pava vaga de desenvolvedor Flutter. Trata-se de um aplicativo com integração com a API da plataforma Dribbble, desde autenticação (OAuth) à publicação de shots (FormData).

Para mais informações a respeito da plataforma:

- [Documentação da API](https://developer.dribbble.com/v2/)

## Informações adicionais

- O aplicativo fornece listagem e cadastro de publicações seguindo a linha offline-first. Quando não há internet, os dados são armazenados de forma local e são sincronizados com o repositório, posteriormente, quando a conexão é reestabelecida. Publicações recentes são exibidas mesmo no cenário offline.

- A implementação de armazenamento local utiliza código nativo android (java) e conversa com o Dart através do recurso de method channel. A aplicação não foi testada em dispositivo IOS e este recurso não deve funcionar.

- Arquitetura baseada no padrão MVVM, aplicando o princípio da inversão de dependência. Gerenciamento de estado global do app através do padrão MobX.

## Observações

- Antentar-se à informação sobre os requisitos dos arquivos de imagens enviados no POST de um shot, como consta na documentação da API: "It must be exactly 400x300 or 800x600, no larger than eight megabytes, and be a GIF, JPG, or PNG."
