# 🚀 Kode Start 2025 – Rick & Morty App

Este é um desafio frontend que desenvolvi durante o programa **Kode Start 2025**.  
O objetivo foi construir uma interface interativa para exibir personagens e episódios da série **Rick & Morty**.  
A versão Android foi implementada com **Kotlin** e **Jetpack Compose**, seguindo boas práticas de arquitetura.

---

## 🛠 Tecnologias & Arquitetura

- **Kotlin** – desenvolvimento Android nativo  
- **Jetpack Compose** – UI declarativa  
- **MVVM (Model-View-ViewModel)** – separação de responsabilidades  
- **StateFlow & LaunchedEffect** – gerenciamento reativo de estado  

**Estrutura modularizada do projeto:**
```
lib/
├── app/
│   ├── ui/
│   │   ├── character/
│   │   ├── episode/
│   │   └── home/
│   └── theme/
└── common/
    ├── components/
    └── utils/```
'''

---

## 📄 Funcionalidades Implementadas

- **🏠 Tela Inicial (`home/`)** – ponto de entrada com navegação para personagens e episódios  
- **👤 Tela de Personagens (`character/`)** – lista de personagens (nome, imagem, status)  
- **🎬 Tela de Episódios (`episode/`)** – lista de episódios (título, descrição, data de lançamento)  
- **🎨 Tema (`theme/`)** – cores, tipografia e estilos consistentes  
- **🔧 Componentes Reutilizáveis (`common/components/`)** – botões, cards, barras de progresso  
- **🛠 Utilitários (`common/utils/`)** – formatação de dados, helpers, funções auxiliares  

---

## 📈 Pontos de Aprendizado & Melhoria

| Desafio Identificado                                   | Status Atual                      | Próximos Passos / Aprendizado                      |
|--------------------------------------------------------|-----------------------------------|----------------------------------------------------|
| Consumo completo da API (filtros, paginação)           | Parcialmente implementado         | Aprimorar lógica de requisições e paginação        |
| Navegação entre telas                                  | Implementada com Compose          | Ajustar animações e transições                     |
| Gerenciamento de estado reativo                        | Parcialmente implementado         | Consolidar uso de `StateFlow` e efeitos colaterais |
| Tratamento de erros e loading                          | Básico (loading simples)          | Melhorar UX com skeletons e mensagens de erro      |
| Testes automatizados (unitários e instrumentados)      | Não implementado                  | Criar testes para ViewModels e Composables         |

---

## ✅ Conclusão

O projeto demonstra:

- Estrutura modularizada e organizada, facilitando manutenção e escalabilidade  
- Boas práticas de MVVM e Jetpack Compose  
- UI reativa e reutilizável  
- Oportunidades de aprimoramento em testes e UX

---

🔗 **Links úteis:**  
- [Repositório no GitHub](https://github.com/talitarolin/kode-start-2025-rick-morty)  
