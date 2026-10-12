-- Corrige URLs de imagem externas quebradas, inclui imagens compactadas no bundle e completa autoria/licença.
-- As referências/atribuições usam chave composta estável; executar novamente não cria duplicações.

update public.cultures set
  cover_image_url = case slug
    when 'cavalo-marinho' then '/images/cavalo.jpg'
    when 'capoeira' then '/images/rugendas.jpg'
    when 'maracatu' then '/images/maracatu.jpg'
    when 'coco-de-roda' then '/images/coco.jpg'
    when 'maculele' then '/images/maculele.jpg'
    else cover_image_url end,
  photo_credit = case slug
    when 'cavalo-marinho' then 'Maria Eugenia Tita · fotografia de 2004 · CC BY 4.0'
    when 'capoeira' then 'Johann Moritz Rugendas · gravura c. 1830 · domínio público (não fotografia)'
    when 'maracatu' then 'Hansfotos · fotografia de 2011 · CC BY-SA 4.0'
    when 'coco-de-roda' then 'MarinaCriscuolo · fotografia de 2019 · CC BY-SA 4.0'
    when 'maculele' then 'Chris Amies · fotografia de 2013 · CC BY 2.0'
    else photo_credit end,
  photo_source_url = case slug
    when 'cavalo-marinho' then 'https://commons.wikimedia.org/wiki/File:Cavalo_Marinho_da_Zona_da_Mata_de_Pernambuco_-_0159.jpg'
    when 'capoeira' then 'https://commons.wikimedia.org/wiki/File:Rugendasroda.jpg'
    when 'maracatu' then 'https://commons.wikimedia.org/wiki/File:Caboclo_de_Lan%C3%A7a_do_Maracatu_Rural.jpg'
    when 'coco-de-roda' then 'https://commons.wikimedia.org/wiki/File:Coco_de_roda_-_dance_from_northeast_of_Brazil.jpg'
    when 'maculele' then 'https://commons.wikimedia.org/wiki/File:Brazilian_Maculele_dance.jpg'
    else photo_source_url end
where (slug='cavalo-marinho' and cover_image_url='https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Cavalo-marinho_2.jpg/800px-Cavalo-marinho_2.jpg')
   or (slug='capoeira' and cover_image_url='https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Rugendas_-_Jogar_Capoeira.jpg/800px-Rugendas_-_Jogar_Capoeira.jpg')
   or (slug='maracatu' and cover_image_url='https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg/800px-Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg')
   or (slug='maculele' and cover_image_url='https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Maculele.jpg/800px-Maculele.jpg')
   or (slug='coco-de-roda' and coalesce(cover_image_url,'')='');

-- Atualiza registros de capa já semeados. O registro de Coco é criado apenas se ainda não existir.
update public.images i set
  url=c.cover_image_url, alt=c.title || ' — imagem de capa',
  caption=case c.slug
    when 'cavalo-marinho' then 'Cavalo-Marinho da Zona da Mata de Pernambuco, fotografia de 2004 durante gravação para TV Futura.'
    when 'capoeira' then '“Jogar capoeira ou dança da guerra”, c. 1830 — gravura histórica de Rugendas, não fotografia.'
    when 'maracatu' then 'Caboclo de lança do Maracatu Rural, fotografia de Hansfotos, 2011.'
    when 'coco-de-roda' then 'Coco de roda no Festival Nacional de Folclore em Olímpia, fotografia de 2019.'
    when 'maculele' then 'Apresentação de Maculelê, fotografia de Chris Amies, 2013.' end,
  credit=c.photo_credit, source_url=c.photo_source_url
from public.cultures c
where i.culture_id=c.id and i.page_id is null
  and ((c.slug='cavalo-marinho' and i.url='https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Cavalo-marinho_2.jpg/800px-Cavalo-marinho_2.jpg')
    or (c.slug='capoeira' and i.url='https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Rugendas_-_Jogar_Capoeira.jpg/800px-Rugendas_-_Jogar_Capoeira.jpg')
    or (c.slug='maracatu' and i.url='https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg/800px-Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg')
    or (c.slug='maculele' and i.url='https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Maculele.jpg/800px-Maculele.jpg'));
insert into public.images(culture_id,url,alt,caption,credit,source_url,sort_order)
select c.id,c.cover_image_url,c.title || ' — imagem de capa',
  case c.slug
    when 'cavalo-marinho' then 'Cavalo-Marinho da Zona da Mata de Pernambuco, fotografia de 2004 durante gravação para TV Futura.'
    when 'capoeira' then '“Jogar capoeira ou dança da guerra”, c. 1830 — gravura histórica de Rugendas, não fotografia.'
    when 'maracatu' then 'Caboclo de lança do Maracatu Rural, fotografia de Hansfotos, 2011.'
    when 'coco-de-roda' then 'Coco de roda no Festival Nacional de Folclore em Olímpia, fotografia de 2019.'
    when 'maculele' then 'Apresentação de Maculelê, fotografia de Chris Amies, 2013.' end,
  c.photo_credit,c.photo_source_url,0
from public.cultures c
where c.slug in ('cavalo-marinho','capoeira','maracatu','coco-de-roda','maculele')
  and not exists(select 1 from public.images i where i.culture_id=c.id and i.page_id is null);

-- As páginas específicas preservam as imagens originais documentais, substituindo apenas arquivos que não carregavam.
update public.images i set
  url='/images/cavalo.jpg', alt='Cavalo-Marinho da Zona da Mata de Pernambuco',
  caption='Cavalo-Marinho da Zona da Mata de Pernambuco, foto de 2004 durante gravação para TV Futura.',
  credit='Maria Eugenia Tita · CC BY 4.0',
  source_url='https://commons.wikimedia.org/wiki/File:Cavalo_Marinho_da_Zona_da_Mata_de_Pernambuco_-_0159.jpg'
from public.pages p join public.cultures c on c.id=p.culture_id
where i.page_id=p.id and p.title='Imagens de Cavalo-Marinho' and c.slug='cavalo-marinho'
  and i.url='https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Cavalo-marinho_2.jpg/800px-Cavalo-marinho_2.jpg';

update public.images i set
  url=case i.sort_order when 1 then '/images/rugendas.jpg' when 2 then '/images/capoeira.jpg' else i.url end,
  alt=case i.sort_order when 1 then 'Gravura histórica de Rugendas representando jogo de capoeira, c. 1830' when 2 then 'Roda de capoeira no Parque da Redenção, Porto Alegre, Brasil (2007)' else i.alt end,
  caption=case i.sort_order when 1 then '“Jogar capoeira ou dança da guerra”, c. 1830 — gravura de Johann Moritz Rugendas; obra histórica, não fotografia.' when 2 then 'Roda de capoeira no Parque da Redenção, Porto Alegre, 2007.' else i.caption end,
  credit=case i.sort_order when 1 then 'Johann Moritz Rugendas · domínio público' when 2 then 'Ricardo André Frantz (Tetraktys) · CC BY-SA 3.0' else i.credit end,
  source_url=case i.sort_order when 1 then 'https://commons.wikimedia.org/wiki/File:Rugendasroda.jpg' when 2 then 'https://commons.wikimedia.org/wiki/File:Roda_de_capoeira1.jpg' else i.source_url end
from public.pages p join public.cultures c on c.id=p.culture_id
where i.page_id=p.id and p.title='Imagens de Capoeira' and c.slug='capoeira' and i.sort_order in (1,2)
  and ((i.sort_order=1 and i.url='https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Rugendas_-_Jogar_Capoeira.jpg/800px-Rugendas_-_Jogar_Capoeira.jpg')
    or (i.sort_order=2 and i.url='https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Capoeira_-_Mestre_Bimba_e_disc%C3%ADpulos.jpg/800px-Capoeira_-_Mestre_Bimba_e_disc%C3%ADpulos.jpg'));

update public.images i set
  url='/images/maracatu.jpg', alt='Caboclo de lança do Maracatu Rural',
  caption='Caboclo de lança do Maracatu Rural, fotografia de Hansfotos, 17 fev. 2011.',
  credit='Hansfotos · CC BY-SA 4.0',
  source_url='https://commons.wikimedia.org/wiki/File:Caboclo_de_Lan%C3%A7a_do_Maracatu_Rural.jpg'
from public.pages p join public.cultures c on c.id=p.culture_id
where i.page_id=p.id and p.title='Imagens de Maracatu de Baque Solto' and c.slug='maracatu'
  and i.url='https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg/800px-Maracatu_Rural_-_Caboclo_de_Lan%C3%A7a.jpg';

update public.images i set
  url='/images/maculele.jpg', alt='Apresentação de Maculelê',
  caption='Apresentação de Maculelê, fotografia de Chris Amies, 1 set. 2013.',
  credit='Chris Amies · CC BY 2.0',
  source_url='https://commons.wikimedia.org/wiki/File:Brazilian_Maculele_dance.jpg'
from public.pages p join public.cultures c on c.id=p.culture_id
where i.page_id=p.id and p.title='Imagens de Maculelê' and c.slug='maculele'
  and i.url='https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Maculele.jpg/800px-Maculele.jpg';

-- Registros de fonte com chave natural única: reaplicar a migração atualiza a nota, sem criar repetidos.
insert into public.references(culture_id,institution,title,url,note,sort_order)
select c.id,'Wikimedia Commons',v.title,v.url,v.note,coalesce((select max(r.sort_order)+1 from public.references r where r.culture_id=c.id),1)
from (values
 ('cavalo-marinho','Maria Eugenia Tita — fotografia do Cavalo-Marinho','https://commons.wikimedia.org/wiki/File:Cavalo_Marinho_da_Zona_da_Mata_de_Pernambuco_-_0159.jpg','Fotografia de 2004 durante gravação para TV Futura. Licença CC BY 4.0; arquivo incluído localmente e redimensionado proporcionalmente.'),
 ('capoeira','Johann Moritz Rugendas — gravura histórica de capoeira','https://commons.wikimedia.org/wiki/File:Rugendasroda.jpg','Obra c. 1830, em domínio público; reprodução de obra de arte histórica, não fotografia.'),
 ('capoeira','Ricardo André Frantz — fotografia de roda de capoeira','https://commons.wikimedia.org/wiki/File:Roda_de_capoeira1.jpg','Roda no Parque da Redenção, Porto Alegre, 2007. Licença CC BY-SA 3.0.'),
 ('maracatu','Hansfotos — fotografia de caboclo de lança','https://commons.wikimedia.org/wiki/File:Caboclo_de_Lan%C3%A7a_do_Maracatu_Rural.jpg','Maracatu Rural, 17 fev. 2011. Licença CC BY-SA 4.0.'),
 ('coco-de-roda','MarinaCriscuolo — fotografia de Coco de Roda','https://commons.wikimedia.org/wiki/File:Coco_de_roda_-_dance_from_northeast_of_Brazil.jpg','Festival Nacional de Folclore em Olímpia, 11 ago. 2019. Licença CC BY-SA 4.0.'),
 ('maculele','Chris Amies — fotografia de Maculelê','https://commons.wikimedia.org/wiki/File:Brazilian_Maculele_dance.jpg','Apresentação de Maculelê, 1 set. 2013. Licença CC BY 2.0.')
) as v(slug,title,url,note)
join public.cultures c on c.slug=v.slug
on conflict(culture_id,title,url) do nothing;

-- Sincroniza os créditos ligados a imagens e insere atribuições ausentes uma única vez.
update public.credits cr set person_or_institution=i.credit, role='Atribuição da imagem',
  text=case when i.credit like '%CC BY%' then 'Licença conforme a página da obra. Arquivo proporcionalmente redimensionado e recomprimido, sem alteração do conteúdo visual.' else 'Obra histórica em domínio público, conforme página da obra; não é fotografia.' end,
  source_url=i.source_url
from public.images i where cr.image_id=i.id and i.url like '/images/%'
  and (cr.person_or_institution ilike 'imagem%' or cr.source_url like 'https://upload.wikimedia.org/%');
insert into public.credits(culture_id,image_id,person_or_institution,role,text,source_url)
select i.culture_id,i.id,i.credit,'Atribuição da imagem',
  case when i.credit like '%CC BY%' then 'Licença conforme a página da obra. Arquivo proporcionalmente redimensionado e recomprimido, sem alteração do conteúdo visual.' else 'Obra histórica em domínio público, conforme página da obra; não é fotografia.' end,
  i.source_url
from public.images i where i.url like '/images/%'
  and not exists(select 1 from public.credits cr where cr.image_id=i.id);

-- A página descreve corretamente a diferença entre gravura histórica e fotografia documental.
update public.pages p set content=p.content || E'\n\nImagem documental contemporânea: roda de capoeira no Parque da Redenção, Porto Alegre, registrada em 2007 por Ricardo André Frantz. Licença CC BY-SA 3.0. A obra de Rugendas é uma gravura histórica reproduzida em domínio público, não uma fotografia.'
from public.cultures c
where p.culture_id=c.id and c.slug='capoeira' and p.title='Imagens de Capoeira'
  and p.content not like '%Imagem documental contemporânea%';

-- Serializa a verificação do limite por cultura/página, para que duas gravações concorrentes não excedam os limites.
create or replace function public.enforce_page_limits() returns trigger
language plpgsql set search_path = public as $$
begin
  if new.is_extra then
    perform 1 from public.cultures c where c.id=new.culture_id for update;
    if (select count(*) from public.pages p where p.culture_id=new.culture_id and p.is_extra and p.id is distinct from new.id) >= 40 then
      raise exception 'Cada cultura pode ter no máximo 40 páginas extras.';
    end if;
  end if;
  return new;
end $$;

create or replace function public.enforce_image_limit() returns trigger
language plpgsql set search_path = public as $$
begin
  if new.page_id is not null then
    perform 1 from public.pages p where p.id=new.page_id for update;
    if (select count(*) from public.images i where i.page_id=new.page_id and i.id is distinct from new.id) >= 2 then
      raise exception 'Cada página pode ter no máximo duas imagens.';
    end if;
  end if;
  return new;
end $$;
