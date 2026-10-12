-- Semente integral do HTML fornecido. IDs estáveis e ON CONFLICT evitam duplicações ao reaplicar.
insert into public.cultures(id,slug,title,category,category_label,region,subtitle,excerpt,story,territorial_note,visual_motif,cover_image_url,photo_credit,photo_source_url,sort_order,published) values ('1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'cavalo-marinho','Cavalo-Marinho','festa','Teatro Popular · Música · Dança','Zona da Mata Norte (PE/PB)','Teatro Popular · Música · Dança','Folguedo cênico-musical que combina teatro, música, dança e poesia, com personagens mascarados e coreografias de pisadas e trupés.','["Folguedo cênico-musical que combina teatro, música, dança e poesia, com personagens mascarados e coreografias de pisadas e trupés."]'::jsonb,'Zona da Mata Norte (PE/PB). Folguedo cênico-musical que combina teatro, música, dança e poesia, com personagens mascarados e coreografias de pisadas e trupés.','Memória, música, dança e saberes da comunidade','https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Cavalo-marinho_2.jpg/800px-Cavalo-marinho_2.jpg','Imagem preservada da versão HTML anterior','https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Cavalo-marinho_2.jpg/800px-Cavalo-marinho_2.jpg',1,true) on conflict(id) do nothing;
insert into public.chapters(id,culture_id,title,intro,sort_order) values ('dd973fa1-b8df-561d-b652-47db44506750'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'Cavalo-Marinho','Folguedo cênico-musical que combina teatro, música, dança e poesia, com personagens mascarados e coreografias de pisadas e trupés.',1) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('f251be67-3fcf-5383-846a-08cb69197fbc'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'dd973fa1-b8df-561d-b652-47db44506750'::uuid,'Identidade e Natureza','Cap. 1','O <strong>Cavalo-Marinho</strong> é um folguedo cênico-musical tradicional da Zona da Mata Norte de Pernambuco e de áreas próximas da Paraíba. Combina teatro popular, música, dança, poesia, improvisação, personagens mascarados e coreografias conhecidas como <em>pisadas</em> e <em>trupés</em>.

Sua relevância não está somente na apresentação pública. A manifestação constitui um sistema de conhecimentos que envolve memória, técnica corporal, música, fabricação de adereços, organização comunitária e transmissão de histórias entre gerações.

Existem registros específicos do <strong>Boi de Ouro</strong> e do <strong>Boi Maneiro</strong> na região, além de pesquisa acadêmica dedicada às formas de aprendizagem de seus mestres.',1,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('8f38f49a-8e97-57c2-9519-10b3a3e9b35c'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'dd973fa1-b8df-561d-b652-47db44506750'::uuid,'Formação Histórica','Cap. 2','O Cavalo-Marinho se desenvolveu no contexto das comunidades rurais da Zona da Mata, região marcada pela produção de cana-de-açúcar e por profundas desigualdades sociais. A história do folguedo deve ser compreendida dentro de um processo mais amplo, no qual trabalhadores rurais criaram e recriaram formas próprias de entretenimento, representação, celebração e expressão coletiva.

A tradição dialoga com matrizes africanas e afro-brasileiras, repertórios ibéricos, religiosidade popular e diferentes formas de teatro e dança. Essas influências não devem ser tratadas como ingredientes isolados: ao longo das gerações, foram reinterpretadas pelas comunidades e pelos próprios brincantes.

<h4>Três questões distintas</h4>

<ul><li><strong>O contexto de formação:</strong> comunidades rurais, trabalho canavieiro, festas e sociabilidade.</li><li><strong>A evolução histórica:</strong> mudanças no repertório, nos personagens, na duração das apresentações e nas formas de organização.</li><li><strong>As memórias de origem:</strong> histórias contadas pelos mestres, que são fontes fundamentais, mas podem apresentar versões diferentes.</li></ul>

Não existe uma data única, comprovada para todos os grupos, que possa ser considerada o nascimento do Cavalo-Marinho. A história de cada grupo precisa ser investigada separadamente.',2,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('0c3b47cd-9da7-584e-83e9-fd78091f04c5'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'dd973fa1-b8df-561d-b652-47db44506750'::uuid,'Estrutura da Brincadeira','Cap. 3','O Cavalo-Marinho não funciona como uma coreografia única. É uma sequência de situações musicais e dramáticas, conduzidas por conhecimentos que os mestres acumulam durante anos.

<h4>O banco musical</h4>

O <strong>banco</strong> é o conjunto responsável por sustentar a dimensão musical da brincadeira. Seus integrantes precisam conhecer os ritmos, as toadas, os momentos de entrada e saída das figuras e as relações entre música e movimento. Os instrumentos mais associados à manifestação incluem: <strong>rabeca</strong> (cordas friccionadas, conduz melodias), <strong>pandeiro</strong> (marcações rítmicas), <strong>ganzá</strong> (agitação), <strong>reco-reco</strong> (raspagem) e <strong>bagem de taboca</strong>.

<h4>Pisadas e trupés</h4>

As <em>pisadas</em> são sequências de movimentos que organizam a participação corporal dos brincantes. Os <em>trupés</em> envolvem trabalho dos pés, deslocamentos, mudanças de direção, acentuação e coordenação coletiva. A pessoa não aprende somente observando uma descrição escrita: aprende pela repetição, pelo contato com brincantes experientes e pela correção prática.

<h4>Aprendizagem</h4>

Mestre Pinto afirma: <em>"se aprende Cavalo Marinho na noite de Sambada"</em>. A transmissão se dá no convívio, na festa e no cotidiano, mais do que em qualquer manual.',3,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('f9f563a9-1dc0-5224-a6df-6749e1596cd5'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'dd973fa1-b8df-561d-b652-47db44506750'::uuid,'Mestres e Linhagens','Cap. 4','<h4>Mestre João Araújo — Boi de Ouro</h4>

Também identificado em registros municipais como <strong>João Cezário Venâncio</strong>, é uma das principais referências da tradição. Nasceu em 1922 e começou a brincar Cavalo-Marinho aos 16 anos, em 1938. É <strong>rabequeiro</strong> e dono do <strong>Boi de Ouro</strong>. Completou 103 anos em fevereiro de 2025, ainda em atividade.

<h4>Mestre Pinto — Boi Maneiro</h4>

É estudado diretamente na pesquisa de Joelson Pereira da Silva sobre os processos de ensino do Cavalo-Marinho. O trabalho também o relaciona ao Boi de Ouro como <em>contramestre</em>, evidenciando a circulação de conhecimentos entre grupos e municípios.

<h4>Mestre Pedro Luiz — Boi Maneiro</h4>

Segundo mestre central da pesquisa acadêmica da UFPB. Desenvolveu seu saber após oficinas e convivência com mestres como Duda Bilau, Lelé e João Araújo.

<h4>Outros mestres citados</h4>

Duda Bilau, Mestre Lelé, Mestre Nerzim, Luiz Miguel, Mestre Zé da Rebeca (Jangada) e João Gambá.',4,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('006c6d75-dffa-5d44-a3a8-619639d256c2'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'dd973fa1-b8df-561d-b652-47db44506750'::uuid,'Personagens','Cap. 5','A sequência de entrada das figuras varia entre grupos. Cada personagem tem função dramática, movimento próprio e relação específica com a música e o público.

<h4>Personagens centrais</h4>

<ul><li><strong>Mateus e Bastião:</strong> figuras cômicas centrais, com fala, improvisação e interação com o público.</li><li><strong>Capitão:</strong> figura de comando que organiza a entrada dos personagens.</li><li><strong>Galantes:</strong> participam de sequências coreográficas específicas.</li><li><strong>Boi:</strong> figura animal de grande importância visual e dramática.</li></ul>

<h4>Ordem no Boi de Ouro</h4>

A ordem documentada inclui: Mateus e Bastião, Capitão, Galantes, Pastorinhas, Valentão, Cavalo, Cobrador, Zepelin, Padre, Diabo, Mané Pequenino, Babau, Zé Friento, Margarida, Mané Chorão e o Boi.

<h4>Ordem segundo Mestre Pinto</h4>

<em>"Primeiro o Mateus, vem o Ambrósio, vem o Soldado, vem os Aicos, depois dos Aico vem o Valentão, vem o Cavalo, depois do Cavalo vem o Pataqueiro, depois vem o Caboclo de Orubá, vem o Pisa Pilão, vem o Mané Chorão..."</em>',5,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('93639919-4720-54c2-b0dc-955c291db0fc'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'dd973fa1-b8df-561d-b652-47db44506750'::uuid,'Patrimônio Educativo','Cap. 6','A pesquisa da UFPB analisa o ensino dos mestres de Cavalo-Marinho, distinguindo três formas de educação que coexistem na transmissão da manifestação.

<h4>Educação informal</h4>

Acontece no cotidiano, na família, nas noites de sambada e no convívio entre gerações. É a forma mais antiga e mais presente.

<h4>Educação não formal</h4>

Ocorre em projetos, oficinas e iniciativas culturais. Municípios da região oferecem <strong>oficinas de Cavalo Marinho</strong> em seus núcleos culturais.

<h4>Educação formal</h4>

Quando a manifestação entra na escola regular, como conteúdo curricular ou projeto pedagógico.

O patrimônio imaterial não é apenas um conjunto de objetos antigos. É um conhecimento vivo, praticado, ensinado e transformado por pessoas e comunidades.',6,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('9fcc0602-5f53-58c1-87f9-8fc185ef45ae'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'dd973fa1-b8df-561d-b652-47db44506750'::uuid,'Mestres, memória e transmissão dos saberes','Dossiê histórico','<h4>Mestre Salustiano (Manoel Salustiano Soares) — 1945–2008</h4>

A Fundação Joaquim Nabuco registra que Manoel Salustiano Soares, conhecido como Mestre Salustiano ou Mestre Salu, nasceu em 12 de novembro de 1945, em Aliança, na Zona da Mata Norte de Pernambuco, e faleceu em 31 de agosto de 2008. Foi artesão e comandante de Cavalo-Marinho. A mesma biografia informa que seu pai, João Salustiano, tocava rabeca e lhe ensinou a construir e tocar o instrumento. Esse vínculo familiar é um exemplo concreto de transmissão de conhecimentos entre gerações.

A pesquisa disponível não autoriza completar uma árvore genealógica com nomes e datas de todos os familiares. Por isso, o acervo registra apenas o parentesco documentado e deixa os demais campos como “não localizado em fonte consultada”.

<h4>O que a documentação institucional confirma</h4>

O Iphan aprovou o registro do Cavalo-Marinho como Patrimônio Cultural do Brasil em 3 de dezembro de 2014. O dossiê destaca a convivência entre integrantes, a transmissão de músicas, personagens, construção de adereços, dança e canto. As apresentações se associam especialmente ao ciclo natalino, mas podem ocorrer durante o ano.

<h4>Como aprofundar as biografias</h4>

Para mestres como João Araújo, Mestre Pinto, Mestre Pedro Luiz, Duda Bilau, Lelé e Nerzim, é necessário cruzar entrevistas, pesquisas acadêmicas e arquivos de cada grupo. O acervo deve distinguir depoimento oral, registro institucional e documento civil; divergências de datas devem aparecer como divergências, não ser resolvidas por suposição.

<h4>Fontes consultáveis</h4>

<ul><li><a href="https://pesquisaescolar.fundaj.gov.br/pt-br/artigo/mestre-salustiano/" target="_blank" rel="noopener noreferrer">Fundação Joaquim Nabuco — biografia de Mestre Salustiano</a></li><li><a href="https://bcr.iphan.gov.br/acoes-de-salvaguarda/registro-do-cavalo-marinho-como-patrimonio-cultural-do-brasil/" target="_blank" rel="noopener noreferrer">Iphan — registro do Cavalo-Marinho</a></li><li><a href="https://www.gov.br/iphan/pt-br/superintendencias/pernambuco/patrimonio-imaterial" target="_blank" rel="noopener noreferrer">Iphan Pernambuco — patrimônio imaterial</a></li></ul>',7,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('99f4e9ee-fc11-5b78-8a57-a3320c375c5f'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'dd973fa1-b8df-561d-b652-47db44506750'::uuid,'Imagens de Cavalo-Marinho','Galeria documental','Imagens e endereços preservados da versão HTML anterior. Confira as páginas de origem e as condições de uso antes de republicar.',8,true) on conflict(id) do nothing;
insert into public.images(id,culture_id,page_id,url,alt,caption,credit,source_url,sort_order) values ('561473a3-fd3a-5ec1-89aa-c5789df99bb8'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'99f4e9ee-fc11-5b78-8a57-a3320c375c5f'::uuid,'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Cavalo-marinho_2.jpg/800px-Cavalo-marinho_2.jpg','Imagem principal de Cavalo-Marinho','Imagem de referência de Cavalo-Marinho','Imagem já presente no HTML anterior.','',1) on conflict(id) do nothing;
insert into public.images(id,culture_id,url,alt,caption,credit,source_url,sort_order) values ('97d9bb80-3c81-5c44-81c6-50229dd3dd7e'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Cavalo-marinho_2.jpg/800px-Cavalo-marinho_2.jpg','Imagem de Cavalo-Marinho','Imagem preservada da versão HTML de origem.','Imagem preservada da versão HTML anterior','https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Cavalo-marinho_2.jpg/800px-Cavalo-marinho_2.jpg',0) on conflict(id) do nothing;
insert into public.credits(id,culture_id,image_id,person_or_institution,role,text,source_url) values ('8816223c-96f4-58ac-964d-88cb5f1a3b90'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'97d9bb80-3c81-5c44-81c6-50229dd3dd7e'::uuid,'Imagem preservada da versão HTML anterior','Crédito da imagem','Atribuição preservada como apresentada no arquivo recebido; confirmar os termos da licença junto à fonte antes de reutilização.','https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Cavalo-marinho_2.jpg/800px-Cavalo-marinho_2.jpg') on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('f91b2ebe-06a3-50b9-9907-025a7a02ffbf'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'Referência bibliográfica citada no HTML anterior','SILVA, Joelson Pereira da. Pisada do coração. UFPB, 2020.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',1) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('813c695d-fd73-5b59-b7e4-a97291994add'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'Referência citada no dossiê','Fundação Joaquim Nabuco — biografia de Mestre Salustiano','https://pesquisaescolar.fundaj.gov.br/pt-br/artigo/mestre-salustiano/','Link preservado do HTML anterior.',2) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('9ba17d7f-273a-5347-96fc-ff232e25ee90'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'Referência citada no dossiê','Iphan — registro do Cavalo-Marinho','https://bcr.iphan.gov.br/acoes-de-salvaguarda/registro-do-cavalo-marinho-como-patrimonio-cultural-do-brasil/','Link preservado do HTML anterior.',3) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('d263974b-42e5-50fb-87b6-1d87818e14e5'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'Referência citada no dossiê','Iphan Pernambuco — patrimônio imaterial','https://www.gov.br/iphan/pt-br/superintendencias/pernambuco/patrimonio-imaterial','Link preservado do HTML anterior.',4) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('6cda5f36-421f-591c-8acd-7b47917a0d11'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'Referência bibliográfica citada no HTML anterior','Fundação Joaquim Nabuco; Iphan — páginas institucionais consultadas em outubro de 2026.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',5) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('0559a742-9ffe-56b4-95dd-ae78d1c99d20'::uuid,'1a9f07e6-97f1-5025-9fb2-255dbc8abd3a'::uuid,'Imagem já incluída no HTML anterior','Imagem de referência de Cavalo-Marinho','https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Cavalo-marinho_2.jpg/800px-Cavalo-marinho_2.jpg','Endereço original preservado; confirme licença e atribuição.',6) on conflict(id) do nothing;
insert into public.cultures(id,slug,title,category,category_label,region,subtitle,excerpt,story,territorial_note,visual_motif,cover_image_url,photo_credit,photo_source_url,sort_order,published) values ('81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'capoeira','Capoeira','danca','Jogo · Música · Resistência','Bahia · Pernambuco · Paraíba','Jogo · Música · Resistência','Expressão afro-brasileira que une corpo, música, resistência e identidade, com linhagens históricas como Mestre Bimba e Mestre Pastinha.','["Expressão afro-brasileira que une corpo, música, resistência e identidade, com linhagens históricas como Mestre Bimba e Mestre Pastinha."]'::jsonb,'Bahia · Pernambuco · Paraíba. Expressão afro-brasileira que une corpo, música, resistência e identidade, com linhagens históricas como Mestre Bimba e Mestre Pastinha.','Memória, música, dança e saberes da comunidade','https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Rugendas_-_Jogar_Capoeira.jpg/800px-Rugendas_-_Jogar_Capoeira.jpg','Imagem preservada da versão HTML anterior','https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Rugendas_-_Jogar_Capoeira.jpg/800px-Rugendas_-_Jogar_Capoeira.jpg',2,true) on conflict(id) do nothing;
insert into public.chapters(id,culture_id,title,intro,sort_order) values ('78c860b6-652d-5045-a5ef-4b1fc27571b0'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'Capoeira','Expressão afro-brasileira que une corpo, música, resistência e identidade, com linhagens históricas como Mestre Bimba e Mestre Pastinha.',2) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('d141dd72-1465-5fa6-a026-f557e7aa00f0'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'78c860b6-652d-5045-a5ef-4b1fc27571b0'::uuid,'História Nacional','Cap. 1','A <strong>capoeira</strong> é uma das expressões afro-brasileiras mais importantes para compreender as relações entre corpo, música, resistência, identidade e transmissão cultural. Sua história está ligada à presença de populações africanas e afrodescendentes no Brasil, às sociedades escravistas, às comunidades urbanas e às transformações políticas posteriores à abolição.

Não é historicamente rigoroso afirmar que a capoeira foi criada por uma única pessoa. Ela se formou por processos coletivos, em diferentes ambientes e ao longo do tempo. Os grandes mestres que conhecemos são fundamentais porque organizaram, transmitiram, registraram ou transformaram determinadas linhagens.

A capoeira foi perseguida e criminalizada em diferentes períodos. No <strong>Código Penal de 1890</strong>, sua prática foi objeto de repressão legal. Durante o século XX, a capoeira passou por processos de reorganização, institucionalização, expansão educacional e reconhecimento patrimonial.

A <strong>Roda de Capoeira</strong> foi registrada pelo IPHAN como patrimônio cultural brasileiro em <strong>2008</strong>. O Ofício dos Mestres e Mestras também recebeu reconhecimento patrimonial.',1,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('c0d93243-6d5c-5cfc-8b7d-d4ac6443c740'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'78c860b6-652d-5045-a5ef-4b1fc27571b0'::uuid,'Grandes Mestres','Cap. 2','<h4>Mestre Bimba — Manoel dos Reis Machado (1899–1974)</h4>

Salvador, Bahia. Organizou a <strong>Capoeira Regional</strong>, sistematizou métodos de ensino e criou uma estrutura pedagógica que ampliou a legitimidade social da capoeira.

<h4>Mestre Pastinha — Vicente Ferreira Pastinha (1889–1981)</h4>

Salvador, Bahia. Defendeu e sistematizou a <strong>Capoeira Angola</strong>, valorizando sua dimensão ritual, musical, filosófica e comunitária.

<h4>Mestre Waldemar da Paixão</h4>

Bairro da <strong>Liberdade</strong>, Salvador. Preservou a tradição das rodas de rua e a musicalidade da capoeira, especialmente por sua relação com o <strong>berimbau</strong>.

<h4>Mestre Traíra</h4>

Salvador, Bahia. Referência histórica da capoeira tradicional, reconhecido pela técnica de jogo e por sua presença na memória das rodas baianas.

<h4>Outros mestres fundamentais</h4>

Mestre João Grande, Mestre João Pequeno, Mestre Canjiquinha, Mestre Caiçara e Mestre Suassuna.',2,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('862a84bf-c4b4-56f1-b178-871b681e9ba9'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'78c860b6-652d-5045-a5ef-4b1fc27571b0'::uuid,'Angola e Regional','Cap. 3','A comparação entre Capoeira Angola e Capoeira Regional é esquemática. Existem diferenças entre grupos da mesma modalidade, e as práticas atuais não se resumem a duas categorias rígidas.

<h4>Capoeira Angola</h4>

Referência histórica em <strong>Mestre Pastinha</strong> e outras linhagens tradicionais. Ênfase em estratégia, diálogo corporal, ritual e malícia.

<h4>Capoeira Regional</h4>

Referência histórica em <strong>Mestre Bimba</strong>. Ênfase em método sistematizado, sequências e desenvolvimento técnico.

<h4>Instrumentos</h4>

<ul><li><strong>Berimbau:</strong> verga, arame e cabaça; tocado com baqueta e caxixi.</li><li><strong>Pandeiro:</strong> acentos, subdivisões e variações de timbre.</li><li><strong>Atabaque:</strong> tambor que fornece base rítmica.</li><li><strong>Agogô:</strong> campânulas metálicas com padrões sonoros.</li><li><strong>Reco-reco:</strong> instrumento de raspagem.</li></ul>

As cantigas podem narrar acontecimentos, homenagear mestres, transmitir ensinamentos ou comentar situações da roda.',3,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('b762dc38-b9d5-5b5f-89d2-37d9b515e1c9'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'78c860b6-652d-5045-a5ef-4b1fc27571b0'::uuid,'Capoeira na Paraíba e em Pernambuco','Cap. 4','A história nacional da capoeira fornece o contexto, mas não substitui a pesquisa sobre os grupos dos dois estados. A investigação local deve identificar academias, associações, rodas de rua, projetos escolares, grupos de Angola e Regional, mestres formados em outras cidades e os processos de transmissão entre gerações.

<h4>Mestre Marcos Traíra</h4>

Desenvolve trabalhos com capoeira e vertentes culturais desde <strong>1993</strong>, com atuação em cidades da Paraíba e de Pernambuco. Em 2026, foi reconhecido pela Academia Brasileira de Ciências, Artes, História e Literatura (ABRASCI) como <strong>Imortal</strong>, integrando o Colegiado de Artes.

<h4>Escola de Capoeira Angola e Regional Arte e Dança da Cultura Negra</h4>

Funciona em Pernambuco, no Estádio Municipal de uma das cidades da região, sob liderança de Mestre Marcos Traíra.

<h4>Núcleos na Paraíba</h4>

Municípios paraibanos da Zona da Mata oferecem <strong>oficinas de Capoeira</strong> em seus Núcleos Culturais, integrando programas municipais de valorização das culturas populares.

A pesquisa também precisa mapear a circulação regional de capoeiristas. Um mestre pode ter nascido em outra cidade e desempenhar papel fundamental na formação de um grupo local.',4,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('5162a6a7-8706-5776-8c06-8b8b58dccd4f'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'78c860b6-652d-5045-a5ef-4b1fc27571b0'::uuid,'Mestres de referência: trajetórias e legado','Dossiê biográfico','<h4>Manoel dos Reis Machado — Mestre Bimba (1899/1900–1974)</h4>

A Fundação Mestre Bimba registra 23 de novembro de 1899 como data de nascimento de Manoel dos Reis Machado, em Salvador, e 5 de fevereiro de 1974 como data de falecimento, em Goiânia. Algumas biografias publicam 1900 como ano de nascimento; a diferença deve ser mantida como divergência entre fontes. A Fundação identifica seus pais como Luiz Cândido Machado e Maria Martinha do Bonfim. Bimba organizou uma metodologia de ensino e desenvolveu a Capoeira Regional a partir de conhecimentos da capoeira praticada em seu tempo e do batuque.

<h4>Vicente Ferreira Pastinha — Mestre Pastinha (1889–1981)</h4>

A Prefeitura de Belo Horizonte informa que Pastinha nasceu em Salvador em 5 de abril de 1889, era filho de um comerciante espanhol e de uma mulher baiana que havia sido escravizada, e fundou o Centro Esportivo de Capoeira Angola. A trajetória de Pastinha é central para a continuidade e valorização da Capoeira Angola. A data de falecimento mais citada é 13 de novembro de 1981; antes de publicar documentos biográficos mais extensos, o acervo deve conferir essa data em fontes institucionais e no dossiê do Iphan.

<h4>Família, descendência e responsabilidade documental</h4>

A Fundação Mestre Bimba identifica Mestre Nenel (Manoel Nascimento Machado), nascido em 26 de setembro de 1960, como filho de Berenice Conceição Nascimento e de Mestre Bimba, e registra sua atuação na preservação da Capoeira Regional. Informações sobre companheiros, filhos, parentes e descendentes de outros mestres só devem ser incluídas quando publicadas por fonte confiável ou fornecidas com consentimento pelos próprios envolvidos.

<h4>Reconhecimento patrimonial</h4>

O Iphan reconheceu a Roda de Capoeira e o Ofício dos Mestres e Mestras da Capoeira como patrimônio cultural brasileiro. A documentação ressalta que os mestres transmitem não apenas movimentos, mas música, rituais, valores, memória e modos de convivência. A capoeira não tem um único criador: é uma tradição coletiva formada e transformada historicamente.

<h4>Fontes consultáveis</h4>

<ul><li><a href="https://bcr.iphan.gov.br/acoes-de-salvaguarda/registro-do-oficio-dos-mestres-e-mestras-da-capoeira-como-patrimonio-cultural-do-brasil/" target="_blank" rel="noopener noreferrer">Iphan — Ofício dos Mestres e Mestras da Capoeira</a></li><li><a href="https://bibliotecadigital.iphan.gov.br/items/11bba387-1a54-4cd9-9a47-f74b38ee3212" target="_blank" rel="noopener noreferrer">Iphan — dossiê Roda de Capoeira e Ofício dos Mestres</a></li><li><a href="https://prefeitura.pbh.gov.br/cultura/ric/personalidades-negras/mestre-pastinha" target="_blank" rel="noopener noreferrer">Prefeitura de Belo Horizonte — Mestre Pastinha</a></li><li><a href="https://fundacaomestrebimba.org.br/mestre-nenel/" target="_blank" rel="noopener noreferrer">Fundação Mestre Bimba — Mestre Nenel</a></li><li><a href="https://fundacaomestrebimba.wordpress.com/mestre-bimba/" target="_blank" rel="noopener noreferrer">Fundação Mestre Bimba — biografia de Mestre Bimba</a></li></ul>',5,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('4ef59050-b82f-58bc-a81c-eb47a709e8a2'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'78c860b6-652d-5045-a5ef-4b1fc27571b0'::uuid,'Imagens de Capoeira','Galeria documental','Imagens e endereços preservados da versão HTML anterior. Confira as páginas de origem e as condições de uso antes de republicar.',6,true) on conflict(id) do nothing;
insert into public.images(id,culture_id,page_id,url,alt,caption,credit,source_url,sort_order) values ('8cc7a36e-bce1-5f2a-b9a2-89c324a980da'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'4ef59050-b82f-58bc-a81c-eb47a709e8a2'::uuid,'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Rugendas_-_Jogar_Capoeira.jpg/800px-Rugendas_-_Jogar_Capoeira.jpg','Imagem principal de Capoeira','Imagem de referência de Capoeira','Imagem já presente no HTML anterior.','',1) on conflict(id) do nothing;
insert into public.images(id,culture_id,page_id,url,alt,caption,credit,source_url,sort_order) values ('683c7cf7-5caf-5e07-af8c-1ff5d1b53f46'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'4ef59050-b82f-58bc-a81c-eb47a709e8a2'::uuid,'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Capoeira_-_Mestre_Bimba_e_disc%C3%ADpulos.jpg/800px-Capoeira_-_Mestre_Bimba_e_disc%C3%ADpulos.jpg','Mestre Bimba e discípulos','Mestre Bimba e discípulos','Imagem já presente no HTML anterior.','',2) on conflict(id) do nothing;
insert into public.images(id,culture_id,url,alt,caption,credit,source_url,sort_order) values ('c30280c1-b2a2-5e15-a53b-04af67b3764b'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Rugendas_-_Jogar_Capoeira.jpg/800px-Rugendas_-_Jogar_Capoeira.jpg','Imagem de Capoeira','Imagem preservada da versão HTML de origem.','Imagem preservada da versão HTML anterior','https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Rugendas_-_Jogar_Capoeira.jpg/800px-Rugendas_-_Jogar_Capoeira.jpg',0) on conflict(id) do nothing;
insert into public.credits(id,culture_id,image_id,person_or_institution,role,text,source_url) values ('90002c34-2dbc-5561-b108-010d5400812a'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'c30280c1-b2a2-5e15-a53b-04af67b3764b'::uuid,'Imagem preservada da versão HTML anterior','Crédito da imagem','Atribuição preservada como apresentada no arquivo recebido; confirmar os termos da licença junto à fonte antes de reutilização.','https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Rugendas_-_Jogar_Capoeira.jpg/800px-Rugendas_-_Jogar_Capoeira.jpg') on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('9f7fd6e9-6c2a-501b-af71-47be95db1f25'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'Referência bibliográfica citada no HTML anterior','IPHAN. Roda de Capoeira e Ofício dos Mestres e Mestras. Brasília, 2008.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',1) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('68dbb5a9-4754-5309-a68c-638320fbf83e'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'Referência bibliográfica citada no HTML anterior','FUNDAÇÃO CULTURAL PALMARES; FUNDAÇÃO MESTRE BIMBA; IPHAN.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',2) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('9a1d2e40-66fb-5c78-8ca3-18abee121cd5'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'Referência bibliográfica citada no HTML anterior','IPHAN; FUNDAÇÃO CULTURAL PALMARES.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',3) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('234742db-b083-5dec-adb3-c29cd25ee03d'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'Referência bibliográfica citada no HTML anterior','ABRASCI; prefeituras da região.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',4) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('167fe3e0-19bb-5749-9d9c-4396122f5dfb'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'Referência citada no dossiê','Iphan — Ofício dos Mestres e Mestras da Capoeira','https://bcr.iphan.gov.br/acoes-de-salvaguarda/registro-do-oficio-dos-mestres-e-mestras-da-capoeira-como-patrimonio-cultural-do-brasil/','Link preservado do HTML anterior.',5) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('7d864910-ffb3-551d-8b35-9a376a38e443'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'Referência citada no dossiê','Iphan — dossiê Roda de Capoeira e Ofício dos Mestres','https://bibliotecadigital.iphan.gov.br/items/11bba387-1a54-4cd9-9a47-f74b38ee3212','Link preservado do HTML anterior.',6) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('c03522c3-cca8-5d38-bbfb-1af652b584d8'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'Referência citada no dossiê','Prefeitura de Belo Horizonte — Mestre Pastinha','https://prefeitura.pbh.gov.br/cultura/ric/personalidades-negras/mestre-pastinha','Link preservado do HTML anterior.',7) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('911f53b1-4c84-5c1d-98ef-7adf46e62b57'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'Referência citada no dossiê','Fundação Mestre Bimba — Mestre Nenel','https://fundacaomestrebimba.org.br/mestre-nenel/','Link preservado do HTML anterior.',8) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('fbbea6ce-958d-57b6-91fc-51f4e7213d50'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'Referência citada no dossiê','Fundação Mestre Bimba — biografia de Mestre Bimba','https://fundacaomestrebimba.wordpress.com/mestre-bimba/','Link preservado do HTML anterior.',9) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('58fe4da8-56b2-5b42-961d-fc3cd0cb7ae5'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'Referência bibliográfica citada no HTML anterior','Iphan; Prefeitura de Belo Horizonte; Fundação Mestre Bimba. Datas divergentes identificadas no texto.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',10) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('1659c8b6-08a7-5f1d-8aef-e56225373406'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'Imagem já incluída no HTML anterior','Imagem de referência de Capoeira','https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Rugendas_-_Jogar_Capoeira.jpg/800px-Rugendas_-_Jogar_Capoeira.jpg','Endereço original preservado; confirme licença e atribuição.',11) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('b89b3d12-6a9b-5018-8fb5-f643c55509e3'::uuid,'81ceaf5e-7a06-5cfe-8cd5-4d9476265d14'::uuid,'Imagem já incluída no HTML anterior','Mestre Bimba e discípulos','https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Capoeira_-_Mestre_Bimba_e_disc%C3%ADpulos.jpg/800px-Capoeira_-_Mestre_Bimba_e_disc%C3%ADpulos.jpg','Endereço original preservado; confirme licença e atribuição.',12) on conflict(id) do nothing;
insert into public.cultures(id,slug,title,category,category_label,region,subtitle,excerpt,story,territorial_note,visual_motif,cover_image_url,photo_credit,photo_source_url,sort_order,published) values ('95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'maracatu','Maracatu de Baque Solto','festa','Cortejo · Poesia · Música','Zona da Mata Norte (PE/PB)','Cortejo · Poesia · Música','Manifestação dos canaviais pernambucanos, com caboclos de lança, mestres de apito e loas improvisadas. Patrimônio Cultural do Brasil desde 2014.','["Manifestação dos canaviais pernambucanos, com caboclos de lança, mestres de apito e loas improvisadas. Patrimônio Cultural do Brasil desde 2014."]'::jsonb,'Zona da Mata Norte (PE/PB). Manifestação dos canaviais pernambucanos, com caboclos de lança, mestres de apito e loas improvisadas. Patrimônio Cultural do Brasil desde 2014.','Memória, música, dança e saberes da comunidade','https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg/800px-Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg','Imagem preservada da versão HTML anterior','https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg/800px-Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg',3,true) on conflict(id) do nothing;
insert into public.chapters(id,culture_id,title,intro,sort_order) values ('726851ec-a67c-56b1-894c-a15556fe712a'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'Maracatu de Baque Solto','Manifestação dos canaviais pernambucanos, com caboclos de lança, mestres de apito e loas improvisadas. Patrimônio Cultural do Brasil desde 2014.',3) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('6c7bee4c-5bd8-5b5f-b555-02a18e070745'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'726851ec-a67c-56b1-894c-a15556fe712a'::uuid,'Baque Solto e Baque Virado','Cap. 1','Uma pesquisa profissional sobre maracatu deve distinguir duas tradições que possuem histórias, estruturas musicais e personagens diferentes.

<h4>Maracatu de Baque Solto</h4>

Também chamado de <strong>Maracatu Rural</strong>, <strong>de Orquestra</strong> ou <strong>de Trombone</strong>. Ligado especialmente à Zona da Mata Norte pernambucana e ao universo dos trabalhadores canavieiros. Foi reconhecido pelo IPHAN como <strong>Patrimônio Cultural do Brasil em 2014</strong>.

<h4>Maracatu de Baque Virado</h4>

Conhecido como <strong>Maracatu Nação</strong>. Associado a cortejos reais, comunidades afro-brasileiras, batuques e tradições de coroação de reis e rainhas negros.',1,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('bb8ea95b-b53b-5821-a394-d317a5775741'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'726851ec-a67c-56b1-894c-a15556fe712a'::uuid,'Formação e Transformação','Cap. 2','A documentação institucional situa a formação dos maracatus mais antigos em <strong>engenhos de cana-de-açúcar</strong>, entre o final do século XIX e o início do século XX. Seus fundadores eram trabalhadores rurais e cortadores de cana.

A manifestação é resultado de um processo complexo de intercâmbio entre folguedos populares. Estudos discutem relações com o <strong>Cavalo-Marinho</strong>, o <strong>bumba meu boi</strong>, as <strong>cambindas</strong>, os <strong>caboclinhos</strong> e outras tradições.

Essa formação histórica interessa diretamente ao estudo da Paraíba e de Pernambuco, pois as cidades da região estão inseridas em uma zona de contato entre os dois estados, próxima aos circuitos culturais da Zona da Mata.',2,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('f0983f3e-30dd-558f-b96a-3fb4ef228aa9'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'726851ec-a67c-56b1-894c-a15556fe712a'::uuid,'Personagens e Música','Cap. 3','<h4>Caboclo de lança</h4>

Personagem emblemático, com <strong>gola bordada</strong>, chapéu ornamentado, lança e chocalhos. Sua atuação envolve movimentos corporais intensos, deslocamentos e grande domínio da indumentária.

<h4>Outros personagens</h4>

Caboclos de pena ou <em>arreiamá</em>, baianas, dama do paço (com a boneca <em>calunga</em>), rei, rainha, Mateus e Catita.

<h4>Orquestra e instrumentos</h4>

A orquestra do Baque Solto combina percussão e sopros: <strong>tarol</strong>, <strong>surdo</strong>, <strong>ganzá</strong>, <strong>cuíca</strong>, <strong>gonguê</strong>, além de <strong>trombones</strong>, <strong>trompetes</strong>, <strong>saxofones</strong> e <strong>clarinetes</strong>.

<h4>Mestre de apito</h4>

Ocupa posição central porque sua atuação articula música e poesia. As <strong>loas</strong> podem envolver improvisação, homenagens, comentários sobre acontecimentos e desafios poéticos.',3,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('0ce9d56e-c73c-5f23-9f04-3d404939683a'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'726851ec-a67c-56b1-894c-a15556fe712a'::uuid,'Mestres e Presença na PB e PE','Cap. 4','Para compreender a história do maracatu, é necessário pesquisar não somente os mestres de apito, mas também os músicos, artesãos, costureiras, bordadores, dirigentes, caboclos de lança experientes e pessoas que mantêm os aspectos rituais do grupo.

<h4>Patrimônios Vivos de Pernambuco</h4>

O Governo de Pernambuco mantém uma política de reconhecimento de mestres, mestras e grupos como <strong>Patrimônios Vivos</strong>, incluindo representantes da poesia popular e de outras expressões tradicionais.

<h4>Presença regional</h4>

Associações de maracatu estão registradas em cidades da Zona da Mata Norte pernambucana e do extremo da Paraíba, incluindo grupos como o <strong>Leão da Fronteira</strong> e o <strong>Leãozinho das Flores</strong>. Feiras folclóricas da região têm incluído apresentações de maracatu entre suas manifestações.

Não há base suficiente, nas fontes consultadas, para afirmar que todos os personagens e grupos mencionados na documentação estadual estejam presentes atualmente em todas as cidades da região. Essa confirmação exige inventário territorial.',4,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('0cdb5ea5-fa42-54fe-9448-bfe4e685bd8c'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'726851ec-a67c-56b1-894c-a15556fe712a'::uuid,'Maracatu de Baque Solto: território, mestres e grupos','Dossiê de patrimônio','<h4>Uma tradição ligada às comunidades canavieiras</h4>

O Iphan descreve o Maracatu de Baque Solto — também chamado maracatu rural, de orquestra ou de trombone — como uma brincadeira de música, dança e poesia associada sobretudo à Zona da Mata Norte de Pernambuco. Registros do inventário indicam que grupos antigos se formaram em engenhos e entre trabalhadores rurais, especialmente cortadores de cana, entre o fim do século XIX e o começo do século XX.

Sua formação não deve ser atribuída a uma origem única. A documentação do Iphan aponta uma composição histórica complexa, com relações com outras manifestações populares, entre elas cambindas, bumba-meu-boi e Cavalo-Marinho. O repertório, os personagens e os sentidos rituais variam entre grupos e comunidades.

<h4>Elementos que precisam ser registrados por grupo</h4>

<ul><li>Nome oficial e nome popular do maracatu, município e comunidade de referência.</li><li>Data de fundação e nome dos fundadores, somente quando confirmados em documentação ou memória oral identificada.</li><li>Presidência, mestre de apito, compositores de loas, artesãos, costureiras, caboclos de lança e demais funções, respeitando a forma como cada grupo se identifica.</li><li>História das fantasias, instrumentos, ensaios, sambadas, calendário e práticas de transmissão.</li><li>Depoimentos com nome, data, autorização de uso e identificação de quem realizou a entrevista.</li></ul>

<h4>Mestres e biografias</h4>

Não existe uma biografia única que represente todos os maracatus. Para incluir nascimento, falecimento, familiares e linhagens de mestres, o próximo passo documental é consultar o dossiê de registro, a Fundarpe, arquivos municipais e os próprios grupos. Não preencher dados pessoais por aproximação nem transferir automaticamente a biografia de um mestre de Cavalo-Marinho para a história de um maracatu, mesmo quando a mesma pessoa atua em mais de uma tradição.

<h4>Reconhecimento patrimonial e fontes</h4>

O Maracatu de Baque Solto foi registrado como Patrimônio Cultural do Brasil em 2014, no Livro de Registro das Formas de Expressão.

<ul><li><a href="https://bcr.iphan.gov.br/bens-culturais/maracatu-baque-solto/" target="_blank" rel="noopener noreferrer">Iphan — Maracatu de Baque Solto</a></li><li><a href="https://sicg.iphan.gov.br/sicg/bemImaterial/rel/596/" target="_blank" rel="noopener noreferrer">Iphan — relatório complementar do bem imaterial</a></li><li><a href="https://www.ivt.coppe.ufrj.br/caderno/article/view/1943" target="_blank" rel="noopener noreferrer">Artigo acadêmico: Maracatu de Baque Solto, de brincadeira a patrimônio cultural</a></li><li><a href="https://www.cultura.pe.gov.br/pagina/patrimonio-cultural/imaterial/patrimonios-vivos/" target="_blank" rel="noopener noreferrer">Fundarpe / Cultura PE — Patrimônios Vivos</a></li></ul>',5,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('bede6b14-0b1a-57b9-9e1c-660727ec0990'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'726851ec-a67c-56b1-894c-a15556fe712a'::uuid,'Imagens de Maracatu de Baque Solto','Galeria documental','Imagens e endereços preservados da versão HTML anterior. Confira as páginas de origem e as condições de uso antes de republicar.',6,true) on conflict(id) do nothing;
insert into public.images(id,culture_id,page_id,url,alt,caption,credit,source_url,sort_order) values ('5a63e03d-65ae-5a5e-8a0d-d30bbb6ac436'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'bede6b14-0b1a-57b9-9e1c-660727ec0990'::uuid,'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg/800px-Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg','Imagem principal de Maracatu de Baque Solto','Imagem de referência de Maracatu de Baque Solto','Imagem já presente no HTML anterior.','',1) on conflict(id) do nothing;
insert into public.images(id,culture_id,url,alt,caption,credit,source_url,sort_order) values ('f3f08fe7-fd6a-55d0-b20f-ee2c7b180637'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg/800px-Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg','Imagem de Maracatu de Baque Solto','Imagem preservada da versão HTML de origem.','Imagem preservada da versão HTML anterior','https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg/800px-Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg',0) on conflict(id) do nothing;
insert into public.credits(id,culture_id,image_id,person_or_institution,role,text,source_url) values ('9aa97de3-dbfd-548d-b6dd-d5e1d71e9ccb'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'f3f08fe7-fd6a-55d0-b20f-ee2c7b180637'::uuid,'Imagem preservada da versão HTML anterior','Crédito da imagem','Atribuição preservada como apresentada no arquivo recebido; confirmar os termos da licença junto à fonte antes de reutilização.','https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg/800px-Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg') on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('0703f058-0d2f-54c8-9c8b-8a809442f20b'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'Referência bibliográfica citada no HTML anterior','IPHAN. Maracatu de Baque Solto. Brasília, 2014.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',1) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('6ebff4f7-157e-5834-b2e8-0c1ef84de0de'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'Referência bibliográfica citada no HTML anterior','IPHAN; FUNDAÇÃO JOAQUIM NABUCO.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',2) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('035d90a4-7362-54e2-ab80-c22e267afac6'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'Referência bibliográfica citada no HTML anterior','GOVERNO DE PERNAMBUCO. Patrimônios Vivos; prefeituras da região.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',3) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('55819e87-9315-5ea8-b617-a75bf5f66d7f'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'Referência citada no dossiê','Iphan — Maracatu de Baque Solto','https://bcr.iphan.gov.br/bens-culturais/maracatu-baque-solto/','Link preservado do HTML anterior.',4) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('ef2baa30-d7f6-5a3e-a7d0-768318b1715b'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'Referência citada no dossiê','Iphan — relatório complementar do bem imaterial','https://sicg.iphan.gov.br/sicg/bemImaterial/rel/596/','Link preservado do HTML anterior.',5) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('96bc7a07-7d35-56c0-929e-f2c374c2a561'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'Referência citada no dossiê','Artigo acadêmico: Maracatu de Baque Solto, de brincadeira a patrimônio cultural','https://www.ivt.coppe.ufrj.br/caderno/article/view/1943','Link preservado do HTML anterior.',6) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('d8a48987-bd51-5184-bcb2-e63148427171'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'Referência citada no dossiê','Fundarpe / Cultura PE — Patrimônios Vivos','https://www.cultura.pe.gov.br/pagina/patrimonio-cultural/imaterial/patrimonios-vivos/','Link preservado do HTML anterior.',7) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('d691f5f5-d4fc-5ce5-8c12-9b262ea12abd'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'Referência bibliográfica citada no HTML anterior','Iphan — dossiê e relatório do Maracatu de Baque Solto; artigo acadêmico publicado no Caderno Virtual de Turismo.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',8) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('805e3cfc-50c8-511e-bb84-9bd4611c3a85'::uuid,'95b586f6-9980-54ab-a60f-e5f09702974b'::uuid,'Imagem já incluída no HTML anterior','Imagem de referência de Maracatu de Baque Solto','https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg/800px-Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg','Endereço original preservado; confirme licença e atribuição.',9) on conflict(id) do nothing;
insert into public.cultures(id,slug,title,category,category_label,region,subtitle,excerpt,story,territorial_note,visual_motif,cover_image_url,photo_credit,photo_source_url,sort_order,published) values ('53495b71-d22a-53da-95b8-1eb1da16b9b5'::uuid,'coco-de-roda','Coco de Roda','danca','Canto · Dança · Memória','Paraíba · Pernambuco · Nordeste','Canto · Dança · Memória','Conjunto de tradições musicais e coreográficas do Nordeste, com cantos responsoriais, percussão e movimentos de roda.','["Conjunto de tradições musicais e coreográficas do Nordeste, com cantos responsoriais, percussão e movimentos de roda."]'::jsonb,'Paraíba · Pernambuco · Nordeste. Conjunto de tradições musicais e coreográficas do Nordeste, com cantos responsoriais, percussão e movimentos de roda.','Memória, música, dança e saberes da comunidade','','Imagem preservada da versão HTML anterior','#',4,true) on conflict(id) do nothing;
insert into public.chapters(id,culture_id,title,intro,sort_order) values ('4644e7f4-f57e-5df2-b20d-751b05918bb9'::uuid,'53495b71-d22a-53da-95b8-1eb1da16b9b5'::uuid,'Coco de Roda','Conjunto de tradições musicais e coreográficas do Nordeste, com cantos responsoriais, percussão e movimentos de roda.',4) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('e94656b6-d254-58fb-82c1-453878e9a067'::uuid,'53495b71-d22a-53da-95b8-1eb1da16b9b5'::uuid,'4644e7f4-f57e-5df2-b20d-751b05918bb9'::uuid,'Tradição Plural','Cap. 1','O <strong>Coco</strong> é um conjunto de tradições musicais, coreográficas e poéticas encontradas em diferentes partes do Nordeste. A expressão <em>coco de roda</em> descreve uma forma de organização coletiva, mas não significa que todas as variantes sejam iguais.

O coco pode ser praticado em rodas, com <strong>cantos responsoriais</strong>, percussão, palmas e movimentos de dança. Em algumas tradições, aparecem passos de umbigada; em outras, o destaque está na pisada, na disposição da roda ou na interação entre cantador e participantes.

A <strong>Lei 15.161/2025</strong> instituiu o <strong>Dia Nacional do Coco de Roda, da Ciranda e da Mazurca</strong> em 26 de julho.',1,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('02f28301-05f8-5ada-82df-b43a2b7a013e'::uuid,'53495b71-d22a-53da-95b8-1eb1da16b9b5'::uuid,'4644e7f4-f57e-5df2-b20d-751b05918bb9'::uuid,'Origens e Estrutura Musical','Cap. 2','As origens do coco são objeto de diferentes narrativas e interpretações. A tradição se desenvolveu em contextos nordestinos marcados por matrizes africanas e indígenas, pela vida rural, pelo trabalho comunitário e pelas transformações das festas populares.

O coco surgiu nos <strong>engenhos de açúcar</strong> da antiga Capitania de Pernambuco, com influências dos batuques africanos e bailados indígenas. A primeira referência data da segunda metade do <strong>século XVIII</strong>.

Uma narrativa recorrente associa o coco à quebra do fruto e às atividades coletivas de trabalho. Essa explicação pode ser importante como memória de determinadas comunidades, mas não deve ser tomada como origem única e comprovada de todas as variantes.

<h4>Instrumentos e corpo</h4>

<ul><li><strong>Ganzá, surdo, pandeiro, triângulo:</strong> base rítmica.</li><li><strong>Tamanco:</strong> sandália de madeira que marca a cadência, imitando o som do coco sendo quebrado.</li><li><strong>Voz e canto responsorial:</strong> um cantador apresenta versos, o conjunto responde com refrões.</li><li><strong>Palmas e percussão corporal:</strong> o corpo dos participantes funciona como parte da base rítmica.</li></ul>',2,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('f20348dc-f8cc-57a1-bfb9-f599e414b420'::uuid,'53495b71-d22a-53da-95b8-1eb1da16b9b5'::uuid,'4644e7f4-f57e-5df2-b20d-751b05918bb9'::uuid,'Mestres e Presença na PB e PE','Cap. 3','No coco, a autoridade cultural pode estar associada a diferentes funções: <strong>puxador de canto</strong>, <strong>coquista</strong>, <strong>poeta</strong>, <strong>dançarino experiente</strong>, <strong>instrumentista</strong> ou <strong>organizador da roda</strong>.

<h4>Temas a investigar</h4>

<ul><li>Cantos de trabalho e cantos festivos.</li><li>Versos de improviso e repertório memorizado.</li><li>Temas de humor, cotidiano, religiosidade e memória.</li><li>Repertórios específicos de famílias e comunidades.</li><li>Participação das mulheres como cantadoras, dançarinas, organizadoras e transmissoras.</li></ul>

<h4>Presença local</h4>

Feiras folclóricas e eventos culturais de cidades da Paraíba e de Pernambuco têm incluído apresentações de <strong>coco</strong> entre suas manifestações. Produtoras culturais e projetos sociais da região oferecem oficinas de <strong>Coco de Roda</strong> entre suas atividades.

Ainda é necessário identificar e confirmar os grupos de coco diretamente vinculados a cada município. A proximidade geográfica com outros territórios nordestinos torna a investigação pertinente, mas não permite atribuir automaticamente a essas cidades a história de grupos de outras localidades.',3,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('d63384ea-fc53-5923-8717-b650b27a84cc'::uuid,'53495b71-d22a-53da-95b8-1eb1da16b9b5'::uuid,'4644e7f4-f57e-5df2-b20d-751b05918bb9'::uuid,'Coco de Roda: variações, comunidades e memória oral','Dossiê de pesquisa','<h4>Uma família diversa de expressões culturais</h4>

O Iphan descreve os Cocos do Nordeste como práticas que combinam música tocada e cantada, poesia, improviso, dança, corporalidade, performance e relação com o território. A expressão inclui diferentes denominações e formas locais, como coco de roda, umbigada, coco praiano e embolada. A tradição possui vínculos afro-brasileiros e indígenas, mas não deve ser reduzida a uma única origem ou a uma forma coreográfica uniforme.

<h4>O contexto da Paraíba</h4>

O Iphan registrou em 2023–2024 a retomada de ações de pesquisa e mobilização para o reconhecimento dos Cocos do Nordeste, com participação de mestres e mestras, músicos, dançarinos e comunidades. A instituição trata o coco como um processo de registro e salvaguarda em construção, portanto o site não deve afirmar que todas as modalidades já possuem reconhecimento nacional individualizado.

<h4>Como documentar mestres e mestras</h4>

A história de cada grupo precisa incluir nome artístico e nome civil apenas quando autorizados/publicamente documentados, comunidade, trajetória de aprendizagem, repertório, pessoas que ensinaram, espaços de atuação e depoimentos. Para nascimento, falecimento e parentesco, registrar apenas o que estiver confirmado; se houver memória oral sem documento, indicar quem contou, quando e em que contexto. A ausência de um registro escrito não diminui a importância do conhecimento comunitário.

<h4>Fontes consultáveis</h4>

<ul><li><a href="https://www.gov.br/iphan/pt-br/assuntos/noticias/edital-seleciona-organizacao-para-o-processo-de-registro-dos-cocos-do-nordeste" target="_blank" rel="noopener noreferrer">Iphan — processo de registro dos Cocos do Nordeste</a></li><li><a href="https://www.gov.br/iphan/pt-br/assuntos/noticias/ciclo-de-reunioes-na-paraiba-aborda-registro-e-salvaguarda-dos-cocos-do-nordeste" target="_blank" rel="noopener noreferrer">Iphan — reuniões na Paraíba e salvaguarda dos Cocos</a></li><li><a href="https://www.gov.br/iphan/pt-br/superintendencias/paraiba" target="_blank" rel="noopener noreferrer">Iphan Paraíba — ações de patrimônio no estado</a></li></ul>',4,true) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('b6908757-fe5c-550b-9571-98609bc152fc'::uuid,'53495b71-d22a-53da-95b8-1eb1da16b9b5'::uuid,'Referência bibliográfica citada no HTML anterior','Lei 15.161/2025; CÂMARA CASCUDO, Luís da. Dicionário do Folclore Brasileiro.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',1) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('70ce9d7e-f135-5a08-b6dc-cfe05042afe7'::uuid,'53495b71-d22a-53da-95b8-1eb1da16b9b5'::uuid,'Referência bibliográfica citada no HTML anterior','CÂMARA CASCUDO, Luís da. Dicionário do Folclore Brasileiro.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',2) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('5a2ed9e6-1855-5eee-87ce-34c43ff96a3c'::uuid,'53495b71-d22a-53da-95b8-1eb1da16b9b5'::uuid,'Referência bibliográfica citada no HTML anterior','Prefeituras e produtoras culturais da região.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',3) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('213c2f8d-b8dd-5826-85df-2daeb293f071'::uuid,'53495b71-d22a-53da-95b8-1eb1da16b9b5'::uuid,'Referência citada no dossiê','Iphan — processo de registro dos Cocos do Nordeste','https://www.gov.br/iphan/pt-br/assuntos/noticias/edital-seleciona-organizacao-para-o-processo-de-registro-dos-cocos-do-nordeste','Link preservado do HTML anterior.',4) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('36fe5b36-175e-5c9b-8692-ffea67be12ad'::uuid,'53495b71-d22a-53da-95b8-1eb1da16b9b5'::uuid,'Referência citada no dossiê','Iphan — reuniões na Paraíba e salvaguarda dos Cocos','https://www.gov.br/iphan/pt-br/assuntos/noticias/ciclo-de-reunioes-na-paraiba-aborda-registro-e-salvaguarda-dos-cocos-do-nordeste','Link preservado do HTML anterior.',5) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('d0ccc6b5-3f53-5217-9446-6e5313a350e6'::uuid,'53495b71-d22a-53da-95b8-1eb1da16b9b5'::uuid,'Referência citada no dossiê','Iphan Paraíba — ações de patrimônio no estado','https://www.gov.br/iphan/pt-br/superintendencias/paraiba','Link preservado do HTML anterior.',6) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('f7cb43c7-45e5-592f-9615-bab6dff16c76'::uuid,'53495b71-d22a-53da-95b8-1eb1da16b9b5'::uuid,'Referência bibliográfica citada no HTML anterior','Iphan — publicações sobre os Cocos do Nordeste e o processo de registro/salvaguarda.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',7) on conflict(id) do nothing;
insert into public.cultures(id,slug,title,category,category_label,region,subtitle,excerpt,story,territorial_note,visual_motif,cover_image_url,photo_credit,photo_source_url,sort_order,published) values ('25bb49b9-d29d-56a4-a1d8-25bb1765c85f'::uuid,'maculele','Maculelê','danca','Dança · Bastões · Ritmo','Bahia · Paraíba · Pernambuco','Dança · Bastões · Ritmo','Manifestação afro-brasileira de dança coletiva com bastões, marcação rítmica, canto e percussão, com raízes em Santo Amaro da Purificação.','["Manifestação afro-brasileira de dança coletiva com bastões, marcação rítmica, canto e percussão, com raízes em Santo Amaro da Purificação."]'::jsonb,'Bahia · Paraíba · Pernambuco. Manifestação afro-brasileira de dança coletiva com bastões, marcação rítmica, canto e percussão, com raízes em Santo Amaro da Purificação.','Memória, música, dança e saberes da comunidade','https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Maculele.jpg/800px-Maculele.jpg','Imagem preservada da versão HTML anterior','https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Maculele.jpg/800px-Maculele.jpg',5,true) on conflict(id) do nothing;
insert into public.chapters(id,culture_id,title,intro,sort_order) values ('e07f3817-7d69-5997-8b6d-3ed5e559ee25'::uuid,'25bb49b9-d29d-56a4-a1d8-25bb1765c85f'::uuid,'Maculelê','Manifestação afro-brasileira de dança coletiva com bastões, marcação rítmica, canto e percussão, com raízes em Santo Amaro da Purificação.',5) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('77851a23-d8a7-5868-b8b8-29f45b008ad3'::uuid,'25bb49b9-d29d-56a4-a1d8-25bb1765c85f'::uuid,'e07f3817-7d69-5997-8b6d-3ed5e559ee25'::uuid,'Identidade e História','Cap. 1','O <strong>Maculelê</strong> é uma manifestação afro-brasileira caracterizada pela dança coletiva com <strong>bastões</strong>, pela marcação rítmica, pelo canto e pela percussão.

Sua história está fortemente associada a <strong>Santo Amaro, no Recôncavo Baiano</strong>, onde a tradição foi preservada e difundida por grupos e mestres. Sua trajetória contemporânea também se relaciona com a expansão de apresentações culturais e com a incorporação do Maculelê a muitas escolas e grupos de capoeira.

É necessário distinguir a memória tradicional, as narrativas de origem e os registros históricos disponíveis.',1,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('ff50fa52-5136-5968-ae6c-f6db4ce1008c'::uuid,'25bb49b9-d29d-56a4-a1d8-25bb1765c85f'::uuid,'e07f3817-7d69-5997-8b6d-3ed5e559ee25'::uuid,'Mestre Popó e Santo Amaro','Cap. 2','A memória do Maculelê de Santo Amaro está fortemente associada a <strong>Mestre Popó</strong>, frequentemente lembrado nas narrativas sobre a preservação e a difusão da manifestação.

Seu nome deve integrar um estudo ampliado do Maculelê porque permite investigar como uma tradição local foi preservada, reorganizada e transmitida a novos praticantes.

Para uma biografia definitiva, devem ser consultados registros históricos e relatos de familiares, discípulos e instituições culturais de Santo Amaro.

<h4>Santo Amaro como centro difusor</h4>

A cidade do Recôncavo Baiano tornou-se, ao longo do século XX, um dos principais centros de preservação e difusão do Maculelê. De lá, a manifestação se espalhou para outras regiões do Brasil, especialmente por meio de grupos de capoeira.',2,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('ac0d2794-d7d5-5e06-9440-81af54b9213c'::uuid,'25bb49b9-d29d-56a4-a1d8-25bb1765c85f'::uuid,'e07f3817-7d69-5997-8b6d-3ed5e559ee25'::uuid,'Técnica e Presença na PB e PE','Cap. 3','Os bastões são elementos centrais do Maculelê. O contato entre eles produz <strong>acentos rítmicos</strong> e exige coordenação, atenção ao parceiro e controle dos movimentos.

<h4>Elementos da execução</h4>

<ul><li>Padrões de batida dos bastões.</li><li>Passos e deslocamentos.</li><li>Coordenação entre os participantes.</li><li>Canto e resposta coletiva.</li><li>Acompanhamento percussivo.</li><li>Organização espacial da apresentação.</li></ul>

O <strong>atabaque</strong> pode sustentar a base rítmica, e outros instrumentos podem ser incorporados conforme a tradição de cada grupo.

<h4>Maculelê e capoeira</h4>

A presença do Maculelê em academias de capoeira não significa que as duas manifestações sejam idênticas. A capoeira tem como elemento corporal central o <em>jogo</em> entre participantes; o Maculelê é <em>dança coletiva com bastões</em>.

<h4>Presença local</h4>

Produtoras culturais e projetos sociais da Paraíba e de Pernambuco oferecem oficinas de <strong>Maculelê</strong> entre suas atividades. Oficinas também foram realizadas na região através de caravanas culturais.',3,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('14caed2b-4f10-5d18-8704-46a74a078176'::uuid,'25bb49b9-d29d-56a4-a1d8-25bb1765c85f'::uuid,'e07f3817-7d69-5997-8b6d-3ed5e559ee25'::uuid,'Maculelê: tradição, reconstrução e mestres','Dossiê de memória oral','<h4>Mestre Popó e a retomada pública do Maculelê</h4>

Estudos acadêmicos sobre o Maculelê descrevem Paulino Aloísio de Andrade, conhecido como Mestre Popó, como figura central na retomada e divulgação da manifestação em Santo Amaro da Purificação, na Bahia, a partir da década de 1940. A pesquisa acadêmica da Universidade Federal do Recôncavo da Bahia usa a tradição oral e entrevistas para discutir sua trajetória e as memórias comunitárias sobre a dança.

Fontes secundárias apresentam datas biográficas para Mestre Popó, mas os relatos sobre a origem remota do Maculelê e os nomes dos primeiros mestres variam. O acervo deve separar a trajetória documentada de Popó das narrativas orais de origem, indicando a fonte de cada versão e evitando transformar uma tradição oral em certeza documental sem explicação.

<h4>Instrumentos, dança e transmissão</h4>

O Maculelê é conhecido pela dança coletiva com bastões, canto responsorial e acompanhamento rítmico. A forma de execução, as letras, os nomes das figuras e a explicação de sua origem podem variar conforme grupo, região e linhagem. A pesquisa deve registrar as versões locais com a identificação do grupo, evitando dizer que todos praticam exatamente da mesma maneira.

<h4>Família e dados pessoais</h4>

As fontes consultadas descrevem Popó reunindo parentes, filhos, vizinhos e amigos para ensinar a dança; isso não basta para preencher nomes de familiares, datas de nascimento ou trajetórias de todos os descendentes. Esses dados só devem ser adicionados após consulta a fontes biográficas confiáveis ou aos familiares e detentores da tradição, com autorização quando necessária.

<h4>Fontes consultáveis</h4>

<ul><li><a href="https://www.ufrb.edu.br/ppgap/images/2024_FLAVIA.pdf" target="_blank" rel="noopener noreferrer">UFRB — pesquisa acadêmica sobre a biografia de Mestre Popó e a memória oral do Maculelê</a></li><li><a href="https://cppa.com.br/Maculel%C3%AA-CPPA/" target="_blank" rel="noopener noreferrer">CPPA — síntese histórica sobre o Maculelê de Santo Amaro</a></li></ul>',4,true) on conflict(id) do nothing;
insert into public.pages(id,culture_id,chapter_id,title,label,content,sort_order,is_extra) values ('97bfb3a1-d433-53be-9dea-7e592b3ac892'::uuid,'25bb49b9-d29d-56a4-a1d8-25bb1765c85f'::uuid,'e07f3817-7d69-5997-8b6d-3ed5e559ee25'::uuid,'Imagens de Maculelê','Galeria documental','Imagens e endereços preservados da versão HTML anterior. Confira as páginas de origem e as condições de uso antes de republicar.',5,true) on conflict(id) do nothing;
insert into public.images(id,culture_id,page_id,url,alt,caption,credit,source_url,sort_order) values ('b13af73e-8ff5-526f-808c-9894f4ba613c'::uuid,'25bb49b9-d29d-56a4-a1d8-25bb1765c85f'::uuid,'97bfb3a1-d433-53be-9dea-7e592b3ac892'::uuid,'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Maculele.jpg/800px-Maculele.jpg','Imagem principal de Maculelê','Imagem de referência de Maculelê','Imagem já presente no HTML anterior.','',1) on conflict(id) do nothing;
insert into public.images(id,culture_id,url,alt,caption,credit,source_url,sort_order) values ('0ba76f93-ed69-5a32-8279-9cd2538fe44b'::uuid,'25bb49b9-d29d-56a4-a1d8-25bb1765c85f'::uuid,'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Maculele.jpg/800px-Maculele.jpg','Imagem de Maculelê','Imagem preservada da versão HTML de origem.','Imagem preservada da versão HTML anterior','https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Maculele.jpg/800px-Maculele.jpg',0) on conflict(id) do nothing;
insert into public.credits(id,culture_id,image_id,person_or_institution,role,text,source_url) values ('3ec9adee-a2ec-57e1-be0a-55613f10fea4'::uuid,'25bb49b9-d29d-56a4-a1d8-25bb1765c85f'::uuid,'0ba76f93-ed69-5a32-8279-9cd2538fe44b'::uuid,'Imagem preservada da versão HTML anterior','Crédito da imagem','Atribuição preservada como apresentada no arquivo recebido; confirmar os termos da licença junto à fonte antes de reutilização.','https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Maculele.jpg/800px-Maculele.jpg') on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('c5673a42-684a-5e45-bdc9-a2f8d9e85b16'::uuid,'25bb49b9-d29d-56a4-a1d8-25bb1765c85f'::uuid,'Referência bibliográfica citada no HTML anterior','Tradição oral; pesquisas sobre o Recôncavo Baiano.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',1) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('717229df-241e-58cc-b452-c24f704ed9e3'::uuid,'25bb49b9-d29d-56a4-a1d8-25bb1765c85f'::uuid,'Referência bibliográfica citada no HTML anterior','Produtoras culturais e caravanas regionais.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',2) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('8b8da216-e04c-59bc-a94d-d0f13f6b418d'::uuid,'25bb49b9-d29d-56a4-a1d8-25bb1765c85f'::uuid,'Referência citada no dossiê','UFRB — pesquisa acadêmica sobre a biografia de Mestre Popó e a memória oral do Maculelê','https://www.ufrb.edu.br/ppgap/images/2024_FLAVIA.pdf','Link preservado do HTML anterior.',3) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('d5fee5e3-d06a-5032-a707-c8ea6f39fe37'::uuid,'25bb49b9-d29d-56a4-a1d8-25bb1765c85f'::uuid,'Referência citada no dossiê','CPPA — síntese histórica sobre o Maculelê de Santo Amaro','https://cppa.com.br/Maculel%C3%AA-CPPA/','Link preservado do HTML anterior.',4) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('c3fef2c2-d51f-5ab1-a272-3895005e4ff6'::uuid,'25bb49b9-d29d-56a4-a1d8-25bb1765c85f'::uuid,'Referência bibliográfica citada no HTML anterior','Universidade Federal do Recôncavo da Bahia — pesquisa acadêmica; fontes de memória oral identificadas no estudo.','#','Referência preservada conforme o conteúdo original; endereço eletrônico não estava informado.',5) on conflict(id) do nothing;
insert into public.references(id,culture_id,institution,title,url,note,sort_order) values ('fb6ba855-bfbc-5674-8b1c-9a50b3b7de47'::uuid,'25bb49b9-d29d-56a4-a1d8-25bb1765c85f'::uuid,'Imagem já incluída no HTML anterior','Imagem de referência de Maculelê','https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Maculele.jpg/800px-Maculele.jpg','Endereço original preservado; confirme licença e atribuição.',6) on conflict(id) do nothing;
