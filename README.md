# Survey API

## Descrição

O `survey_api` é uma API desenvolvida com Ruby on Rails e GraphQL que permite a criação dinâmica de pesquisas (surveys). Sistema suporta dois tipos de usuários e utiliza JWT para autenticação e autorização. Através desta API, os usuários podem criar pesquisas, adicionar perguntas, definir opções e consultar os resultados. O objetivo principal do projeto é oferecer uma plataforma flexível para a criação e gerenciamento de pesquisas.

[Link do pdf do teste técnico](https://drive.google.com/file/d/1FMj20aHE4UI_rBnzFsV-gtEhcFCMCi2u/view?usp=sharing)

## Funcionalidades

- **Criação de Surveys**: Permite a criação de pesquisas com um título e estado (aberto ou fechado).
- **Adição de Perguntas**: Adiciona perguntas às pesquisas, com opções como caixas de seleção, botões de rádio, resposta de linha única e resposta de várias linhas.
- **Respostas às Perguntas**: Permite a criação de respostas para as opções definidas nas perguntas.
- **Consultas e Resultados**: Permite consultar todas as pesquisas, obter detalhes de uma pesquisa específica, e obter o resultado das pesquisas, incluindo contagem de escolhas.

## Tipos de Usuários

- **Coordinator**:
  - Pode criar, atualizar e deletar pesquisas.
  - Pode criar, atualizar e deletar perguntas e opções de resposta.
  - Pode visualizar pesquisas e seus resultados.

- **Respondent**:
  - Pode responder às pesquisas.
  - Pode visualizar pesquisas e seus resultados.

## Autenticação e Autorização

- O sistema usa **JWT** (JSON Web Tokens) para autenticação e autorização.
- Os usuários devem fornecer um token válido para acessar as funcionalidades da API.

## Tecnologias Utilizadas

- Ruby 3
- Rails 7
- GraphQL
- JWT
- PostgreSQL
- Rspec
- FactoryBot (para testes)

## Instalação

1. **Clone o repositório**:
    ```bash
    git clone https://github.com/seu-usuario/survey_api.git
    ```

2. **Instale as dependências**:
    ```bash
    cd survey_api
    bundle install
    ```

3. **Configure o banco de dados**:
    ```bash
    rails db:setup
    ```

4. **Inicie o servidor**:
    ```bash
    rails server
    ```

5. **Acesse a API**:
   - Acesse a API GraphQL na URL: `http://localhost:3000/graphql`

## Endpoints

### Queries

- **`surveys`**: Retorna todas as pesquisas.
- **`survey(id: ID!)`**: Retorna uma pesquisa específica pelo ID.
- **`question(id: ID!)`**: Retorna uma pergunta específica pelo ID.
- **`surveys_lists`**: Retorna listas de pesquisas completas, abertas e fechadas.

### Mutations

- **`createSurvey(title: String!, open: Boolean)`**: Cria uma nova pesquisa.
- **`updateSurvey(id: ID!, title: String, open: Boolean)`**: Atualiza uma pesquisa existente.
- **`deleteSurvey(id: ID!)`**: Deleta uma pesquisa existente.
- **`createQuestion(title: String!, option: String!, order: Int!, surveyId: ID!)`**: Adiciona uma nova pergunta a uma pesquisa.
- **`updateQuestion(id: ID!, title: String, option: String, order: Int)`**: Atualiza uma pergunta existente.
- **`deleteQuestion(id: ID!)`**: Deleta uma pergunta existente.
- **`createChoice(value: String!, questionId: ID!)`**: Adiciona uma nova opção de resposta a uma pergunta.
- **`updateChoice(id: ID!, value: String)`**: Atualiza uma opção de resposta existente.
- **`deleteChoice(id: ID!)`**: Deleta uma opção de resposta existente.
- **`createChoiceAnswer(userId: ID!, choiceId: ID!)`**: Registra a resposta de um usuário a uma opção de resposta.

## Exemplo de Uso

- **Criar uma Pesquisa**:
    ```graphql
    mutation {
      surveyCreate(title: "Pesquisa Exemplo", open: true) {
        survey {
          id
          title
          open
        }
      }
    }
    ```

- **Adicionar uma Pergunta**:
    ```graphql
    mutation {
      questionCreate(title: "Qual a sua cor favorita?", option: "radio_button", order: 1, surveyId: "ID_DA_SURVEY") {
        question {
          id
          title
          option
          order
        }
      }
    }
    ```

- **Consultar Todos os Surveys**:
    ```graphql
    query {
      surveys {
        id
        title
        open
      }
    }
    ```

- **Consultar Resultados de uma Pesquisa**:
    ```graphql
    query {
      survey(id: "ID_DA_SURVEY") {
        id
        title
        result
      }
    }
    ```

## Testes

Para executar os testes:

```bash
rspec
