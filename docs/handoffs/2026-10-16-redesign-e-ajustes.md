HANDOFF 2026-10-16 (redesign do pacote claude-mods, reflect-mod e ajustes de uso real)

ESTADO: os 8 repositórios em `~/Dev/Personal/Repos/claude-mods/` estão no `main`, publicados, sem nada pendente. Versões instaladas: mods 0.7.0, skins 0.10.3, cache-tax 2.5.1, filetree 0.5.3, savvy-progress 1.5.2, replay-theater 0.4.1, blast-radius 0.3.1, reflect-mod 3.4.0. Nenhum servidor desta sessão ficou rodando.

FEITO:
- Redesign de todos os mods sobre um kit comum (`claude-mods-hub/kit`), com visual nativo do Claude Code, cores do skin e skin `claude` como padrão. Aprovado e no `main`; a tag `pre-redesign` existe em todo repositório, e a volta é `sh marketplace/scripts/rollback-redesign.sh`.
- `/mods` virou lista de mods com visão de cada um, aba Componentes e Ajustes (idioma, "Abrir ao iniciar", ligado para o usuário).
- Ajustes no escopo do usuário: `$.store` é a fonte, relido antes do `panel` e a cada 3 s; os itens só da sessão são marcados `scope: 'session'`.
- O filetree e o savvy saíram do `$.config` (o Claude Code não expõe linhas de plugin) para o `$.store`.
- O filetree fecha o painel restaurado pelo app quando "Abrir ao iniciar" está desligado.
- O claude-reflect em Python foi trocado pelo reflect-mod (fork `mvacoimbra/claude-reflect`, pasta `mod`), com a aba Reflect e sem comandos.
- Faixa do skins compacta: ícone do cache com o tempo e um botão `⊟` para Compactar, cada um com cartão ao passar o mouse.
- Prévia fora do app: `claude-mods-hub/dev/preview/` (render.mjs, shot.sh, hub.sh). DESIGN.md e PRODUCT.md estão em `~/Dev/Personal/Repos/claude-mods/`.

PRÓXIMOS (em ordem):
1. Confirmar no app o que só foi visto na prévia: os cartões da faixa em larguras estreitas, o `⊟` no estado de aviso (botão plain não muda com primary; se o usuário quiser um sinal visível, pôr um ponto amarelo ao lado, em `claude-skins/hooks/rows.tsx` `usageBand`) e o Files fechando ao iniciar.
2. Protocolo do hub: um item "regra com ações" (linha com botões embaixo, como o `below` do kit) para a aba Reflect ligar cada regra aos seus botões (pedido do agente do reflect; `claude-mods-hub/types/index.d.ts` e `hooks/register.tsx`).
3. De tempos em tempos, merge do upstream de cada fork (`git fetch upstream && git merge upstream/main`), mantendo o kit e o visual.
4. Opcional: apagar os branches `redesign` no GitHub (idênticos ao `main`; o usuário preferiu manter por enquanto).

AGUARDANDO O USUÁRIO:
- Feedback do uso real.
- Atualizar o Impeccable para a v4.5.2 (`npx impeccable update`), só se ele pedir.

ARMADILHAS:
- O mod blast-radius segura comandos com `rm`, `git reset --hard`, `git clean` e force push digitados no Bash. Use `mv` para `/tmp/claude-501/trash/`.
- `$.config.list/set` só alcança as configurações do próprio Claude Code, nunca o userConfig de plugin. Ajuste de mod vai no `$.store`.
- Cartão ao passar o mouse: a Box escondida (`display: 'none'` + `hover: { display: 'flex' }`) não pode ter `key` própria e precisa ficar dentro de uma Box visível com key. A faixa acima do prompt tem 1 linha e corta o que for mais alto: cartão de uma linha, sem borda.
- Uma árvore de outro mod que chega ao hub precisa ser dado puro: use o `staticTree(node, tone)` do kit; um Button sem onPress derruba o painel inteiro.
- O kit se edita só em `claude-mods-hub/kit`, depois `claude-mods-hub/dev/sync-kit.sh`. Nunca edite as cópias em `hooks/kit`.
- Atualizar um mod instalado exige subir a versão no `plugin.json`; depois `claude plugin marketplace update claude-mods` e `claude plugin update <mod>@claude-mods`, e reiniciar o app com Cmd+Q.
- Se o push por SSH falhar (agente do 1Password bloqueado), envie por HTTPS só naquele comando: `git -c credential.helper= -c credential.helper='!gh auth git-credential' push https://github.com/mvacoimbra/<repo>.git main`.
- Os tipos do engine não vêm no repositório: `perl -e 'alarm 40; exec @ARGV' claude --plugin-dir . -p "reply ok" --max-turns 1` gera `.claude-plugin/types/claude-code/index.d.ts`.
