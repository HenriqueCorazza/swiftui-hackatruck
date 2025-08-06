# 📅 4 DIAS DE PROJETO – Construção de Protótipo de APP, projeto final em grupo.
---
# 💊 FarmaHack – Aplicativo de Controle de Medicamentos com Assistência para Idosos

<img width="500" height="499" alt="Logo" src="https://github.com/user-attachments/assets/55db8558-b8a5-4a32-8c61-d46489f32d49" />


## 👥 Projeto Final – Desenvolvido em Equipe (5 integrantes)

Protótipo funcional construído como conclusão do curso de SwiftUI, com foco em **acessibilidade**, **saúde digital** e **qualidade de vida** para o público idoso.

---

## 🎯 Objetivo

Criar um app intuitivo que ajude **idosos** a:

- Controlar o estoque de seus medicamentos
- Receber **lembretes** automatizados para tomar remédios
- Cadastrar medicamentos facilmente com o auxílio de **foto + IA**
- Localizar **farmácias próximas** com interatividade no mapa
- Centralizar informações úteis como função e efeitos colaterais do medicamento

---

## 🎨 Design e Acessibilidade

- Interface com **tons claros de azul**, promovendo calma e leitura facilitada
- **Ícones grandes e bem distribuídos** para facilitar o uso por pessoas com baixa acuidade visual
- Navegação por **TabView** simples e clara
- Fluxos curtos e autoexplicativos, com textos de apoio em todas as telas

---

## 📱 Funcionalidades principais

- Navegação principal por meio de **TabView**, permitindo o acesso rápido às seções do app.
- Cadastro e controle de medicamentos com campos para:
  - Nome
  - Quantidade em estoque
  - Uso principal
  - Efeito colateral
- Cadastro inteligente de medicamentos por **imagem**, com leitura assistida utilizando **Gemini AI**.
- Mapa interativo exibindo **farmácias próximas** utilizando **MapKit**, com **anotações clicáveis** que mostram detalhes do local.
- Criação de **lembretes e alarmes** integrados ao **calendário do iOS** para avisar a hora de tomar os remédios.
- Comunicação com uma **API própria** desenvolvida em **Node-RED**, simulando endpoints reais.
- Armazenamento das informações em banco de dados na nuvem via **Cloudant**.
- Interface amigável e intuitiva, com **botões e ícones grandes**, pensada especialmente para o público **idoso**.


---

## ✅ Tecnologias e Recursos Aplicados

- SwiftUI (interface, navegação e usabilidade)
- **TabView** para menus principais
- **MapKit + Annotations interativas** (cliques em pontos de farmácia)
- **Gemini AI + PhotoPicker** para leitura de medicamentos via imagem
- **Node-RED** para simular endpoints personalizados REST
- **Cloudant (IBM)** como banco de dados em nuvem
- **Calendar e AlarmManager iOS** para alarmes de remédios
- `@State`, `@Published`, `@ObservedObject`, `AsyncImage`, `NavigationStack`
- Utilização de `ForEach`, `Structs` e `Codable` para organização e API

---

## 📘 Documentação complementar

- 📂 Video:
  - Demonstrando utilização do APP
  - Cadastro via foto de medicamento
  - Exclusão
  - Navegação entre as Tabs
  - Navegação no mapa

> O arquivo está disponível na raiz do repositório como [`FarmaHackVideo1`](FarmaHackVideo1) e [`FarmaHackVideo2`](FarmaHackVideo2)

---

## 🌍 Impacto Social

O FarmaHack nasceu com o propósito de:

- **Facilitar a vida de idosos e cuidadores**
- Reduzir esquecimentos e falhas no uso de medicamentos
- Promover maior **autonomia** com tecnologia acessível
- Prover uma **solução prática, rápida e humana** para um problema real

---

## 🏁 Status

✅ Projeto parcialmente finalizado e aprovado no curso.  
🔄 Futuras melhorias podem incluir autenticação de usuários e integração com HealthKit.

---

