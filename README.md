# Bestiário Cultural — arquivo vivo

Aplicação **React + TypeScript + Vite** para o acervo de cinco manifestações culturais da Paraíba e de Pernambuco. A interface preserva o símbolo “BC” com raios, a paleta de livro antigo, a estrutura e o conteúdo de origem. O modo de leitura funciona sem credenciais usando o acervo incorporado; configurar o Supabase ativa leitura sincronizada, autenticação e edição persistente. **Não há Cloudinary.**

## Funcionalidades

- Abas independentes: Início/Capa, Livro digital, Catálogo e Créditos.
- Livro com navegação anterior/próxima, teclado, índice de capítulos/páginas e abertura do capítulo correspondente a cada cultura.
- Catálogo com busca textual em nomes, regiões, conteúdo e referências, filtros por categoria e cartões com fotos.
- Painel autenticado via Supabase Auth, com autorização adicional em `admin_users` e RLS no Postgres e no Storage.
- CRUD e ordenação de culturas e páginas; até 40 páginas extras por cultura; até duas imagens por página; edição de metadados visuais, referências e créditos.
- Upload de imagens do computador (até 10 MB) ou cadastro de URL. Uploads editoriais são armazenados no Supabase Storage; metadados ficam no banco.
- Banco, políticas RLS, bucket e dados iniciais em três migrações SQL idempotentes.
- Rewrite da SPA no Vercel para `/` e `/admin`.

## Requisitos

- Node.js 20+ (Node 22 recomendado) e npm.
- Projeto Supabase (Postgres, Auth e Storage) para persistência, login e operações administrativas. Sem Supabase, o site continua em modo de leitura local, sem salvar alterações.

## Rodar localmente

```bash
cp .env.example .env.local
# preencher as duas variáveis VITE_* com valores publicáveis
npm install
npm run dev
```

Validação de tipos: `npm run typecheck`. Build de produção: `npm run build`; preview: `npm run preview`.

## Conectar o Supabase

1. Crie um projeto Supabase e abra **SQL Editor**.
2. Execute integralmente, nesta ordem:
   - `supabase/migrations/202610090001_init.sql`
   - `supabase/migrations/202610090002_seed.sql`
   - `supabase/migrations/202610090003_photos_and_attribution.sql`
3. As migrações criam as tabelas, RLS, bucket, limites, acervo e créditos. Os registros de seed têm IDs determinísticos ou chaves naturais para evitar duplicações. A última migração corrige os links de imagens que não carregavam.
4. Crie/invite uma conta editorial em **Authentication → Users**. A aplicação não inclui senha padrão, usuário administrativo ou cadastro público.
5. Copie o **User UID** da conta e promova-a no SQL Editor:

```sql
insert into public.admin_users (user_id)
values ('UUID-DO-USUARIO-AUTORIZADO')
on conflict (user_id) do nothing;
```

A função `public.is_admin()` verifica essa associação. Usuários autenticados comuns não são administradores. Para remover o acesso, execute `delete from public.admin_users where user_id = 'UUID';`.

6. **Enviar os arquivos iniciais ao Supabase Storage** (recomendado): as imagens licenciadas estão incluídas em `public/images/` para que o ZIP e o primeiro deploy funcionem sem serviços externos de imagem. Após rodar as migrações, faça uma sincronização administrativa única. Execute na raiz do projeto, em uma sessão local protegida:

```bash
SUPABASE_URL='https://SEU-PROJETO.supabase.co' \
SUPABASE_SERVICE_ROLE_KEY='SUA_CHAVE_PRIVADA' \
npm run sync:seed-images
```

O script transfere apenas imagens pendentes para `bestiario-images`, troca os URLs na tabela e atualiza as capas; é idempotente. **`SUPABASE_SERVICE_ROLE_KEY` é exclusivamente para essa execução local**: nunca a grave em `.env.local`, repositório, ZIP, Vercel ou código do navegador. O painel usa somente a chave pública e RLS.

7. Defina `.env.local` para desenvolvimento e as mesmas variáveis publicáveis no Vercel (**Project → Settings → Environment Variables**):

```dotenv
VITE_SUPABASE_URL=https://SEU-PROJETO.supabase.co
VITE_SUPABASE_ANON_KEY=SUA_CHAVE_PUBLICAVEL_ANON
```

Use somente a URL e a chave anon/publicável na interface. Não configure `service_role` na Vercel. Ajuste os URLs permitidos em **Supabase Auth → URL Configuration** para o domínio do projeto e `http://localhost:5173`.

RLS limita a leitura pública às culturas publicadas e dados associados. Escrita no banco e Storage exige sessão autenticada e concessão explícita em `admin_users`. O bucket serve imagens públicas, mas não permite upload público. Limites também são verificados no banco, inclusive com serialização para evitar excesso em gravações concorrentes.

## Implantar no Vercel

1. Descompacte o ZIP e importe a pasta em um repositório Git ou faça deploy pelo CLI da Vercel.
2. Escolha o framework **Vite**, comando `npm run build` e diretório `dist`.
3. Configure `VITE_SUPABASE_URL` e `VITE_SUPABASE_ANON_KEY` nos ambientes necessários.
4. Execute as migrações SQL na sequência indicada e, de um ambiente local protegido, sincronize as imagens iniciais conforme o passo acima.
5. Faça deploy. `vercel.json` reescreve rotas da SPA e a página administrativa é acessível em `/admin`.
6. Adicione o domínio Vercel à configuração de URLs permitidos do Supabase Auth e confirme o fluxo de convite/login.

## Conteúdo, imagens e referências

- `source/bestiario-cultural-original.html` guarda uma cópia do arquivo recebido; `supabase/seed-source.json` preserva a extração do material; `src/seed.json` alimenta o modo sem Supabase e contém as atribuições atualizadas.
- As fotos externas do HTML original retornaram erro HTTP 400 durante a validação. Para evitar cartões e páginas quebradas, o projeto inclui arquivos reais de Wikimedia Commons com licenças verificadas, sem geração por IA. A gravura de Rugendas é identificada corretamente como obra histórica, não fotografia.
- Créditos, contexto, licenças e páginas originais estão em [`public/images/README.md`](public/images/README.md), no catálogo de créditos e nas referências do banco. As imagens foram apenas redimensionadas proporcionalmente e recomprimidas, sem corte.
- Novos uploads feitos pelo painel vão diretamente ao Supabase Storage; URLs informadas pelo painel são guardadas como metadados e exibidas segundo a política pública do acervo.

## Segurança e limitações conhecidas

- O acesso público usa somente a chave anon/publicável com RLS; a autorização editorial é verificada no Postgres, não por uma senha codificada no bundle.
- Configure MFA, políticas de senha e a recuperação de conta segundo a operação editorial.
- Sem variáveis, migrações ou Supabase disponível, o modo incorporado é somente leitura. A edição requer credenciais/configuração e conta explicitamente autorizada.
- Este pacote não contém credenciais, projeto Supabase hospedado nem conta administrativa. Por isso, login real, persistência entre dispositivos, RLS e upload ao Storage devem ser validados após configurar o projeto do destinatário.
- Os créditos e links de licença das fotos estão incluídos; verifique direitos de personalidade/consentimento para reutilizações específicas.

## Estrutura

```text
src/main.tsx                        Interface, livro, busca, administração
src/style.css                       Sistema visual responsivo
src/supabase.ts                     Cliente público e modelos Supabase
src/seed.json                       Acervo incorporado para leitura/fallback
public/images/                      Fotografias e gravura otimizadas
public/images/README.md             Atribuições e licenças das imagens
source/bestiario-cultural-original.html  Arquivo recebido, preservado como referência
supabase/migrations/                Esquema, RLS, Storage, seed e imagens
supabase/seed-source.json           Fonte extraída do HTML recebido
scripts/sync-seed-images.mjs        Cópia protegida do seed ao Supabase Storage
public/manus-routes.json            Manifesto de rotas
vercel.json                         Rewrite SPA e cabeçalhos
.env.example                        Apenas variáveis públicas, sem segredos
```
