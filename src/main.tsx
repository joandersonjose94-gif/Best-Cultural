import React, { useCallback, useEffect, useMemo, useState } from 'react';
import { createRoot } from 'react-dom/client';
import DOMPurify from 'dompurify';
import { ArrowLeft, ArrowRight, BookOpen, ChevronDown, ChevronLeft, ChevronRight, Compass, ExternalLink, Feather, Filter, ImagePlus, List, LogIn, LogOut, Menu, Search, ShieldCheck, Sparkles, Upload, X } from 'lucide-react';
import seed from './seed.json';
import { supabase, supabaseReady, type Chapter, type Culture, type Page, type ImageRecord, type ReferenceRecord, type CreditRecord } from './supabase';
import './style.css';

type Legacy = (typeof seed)[number];
type View = 'cover' | 'reader' | 'catalog' | 'credits' | 'admin';
type Bundle = { cultures: Culture[]; chapters: Chapter[]; pages: Page[]; images: ImageRecord[]; references: ReferenceRecord[]; credits: CreditRecord[] };
const legacyBundle = (): Bundle => {
  const cultures: Culture[] = seed.map((c: Legacy, n) => ({ id: c.slug, slug: c.slug, title: c.title, category: c.category, category_label: c.categoryLabel, region: c.region, subtitle: c.subtitle, excerpt: c.excerpt, story: c.story, territorial_note: c.territorialNote, visual_motif: c.visualMotif, cover_image_url: c.image, photo_credit: c.photoCredit, photo_source_url: c.photoSourceUrl, sort_order: n + 1, published: true }));
  const chapters: Chapter[] = seed.map((c: Legacy, n) => ({ id: `chapter-${c.slug}`, culture_id: c.slug, title: c.title, intro: c.excerpt, sort_order: n + 1 }));
  const pages: Page[] = []; const images: ImageRecord[] = []; const references: ReferenceRecord[] = []; const credits: CreditRecord[] = [];
  seed.forEach((c: Legacy) => {
    c.extraPages.forEach((p, n) => { const pageId=`${c.slug}-page-${n}`; pages.push({ id: pageId, culture_id: c.slug, chapter_id: `chapter-${c.slug}`, title: p.title, label: p.eyebrow, content: p.content, sort_order: n + 1, is_extra: true }); (p.images??[]).forEach((im,j)=>images.push({id:`${pageId}-image-${j}`,culture_id:c.slug,page_id:pageId,storage_path:null,url:im.url,alt:im.alt,caption:im.caption,credit:im.credit,source_url:(im as {source_url?:string}).source_url??'',sort_order:j+1})); });
    c.extraPages.forEach((p,n)=>(p.images??[]).forEach((im,j)=>{if(im.url===c.image)return;const sourceUrl=(im as {source_url?:string}).source_url??'';const imageId=`${c.slug}-page-${n}-image-${j}`;credits.push({id:`${imageId}-credit`,culture_id:c.slug,image_id:imageId,person_or_institution:im.credit,role:'Crédito da imagem',text:im.credit.includes('CC BY')?`Atribuição: ${im.credit}. Consulte os termos no arquivo original.`:`Atribuição: ${im.credit}. Consulte a página da obra para os termos aplicáveis.`,source_url:sourceUrl});}));
    if (c.image) { images.push({ id: `${c.slug}-cover`, culture_id: c.slug, page_id: null, storage_path: null, url: c.image, alt: `Imagem de ${c.title}`, caption: c.coverCaption ?? c.title, credit: c.photoCredit, source_url: c.photoSourceUrl, sort_order: 0 }); credits.push({ id: `${c.slug}-credit`, culture_id: c.slug, image_id: `${c.slug}-cover`, person_or_institution: c.photoCredit, role: 'Crédito da imagem', text: c.photoCredit.includes('CC BY') ? `Atribuição: ${c.photoCredit}. Arquivo comprimido proporcionalmente para publicação; sem alteração do conteúdo visual.` : `Atribuição: ${c.photoCredit}. Consulte a página da obra para a descrição e os termos aplicáveis.`, source_url: c.photoSourceUrl }); }
    c.sources.forEach((r, n) => references.push({ id: `${c.slug}-ref-${n}`, culture_id: c.slug, institution: r.institution, title: r.title, url: r.url, note: r.note, sort_order: n + 1 }));
  });
  return { cultures, chapters, pages, images, references, credits };
};
const fallback = legacyBundle();
const safeHtml = (html: string) => ({ __html: DOMPurify.sanitize(html, { ALLOWED_TAGS: ['p','br','strong','b','em','i','u','h4','ul','ol','li','a','blockquote'], ALLOWED_ATTR: ['href','target','rel'] }) });
const slugify = (value: string) => value.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
const err = (e: unknown) => e instanceof Error ? e.message : String(e);

function App() {
  const [bundle, setBundle] = useState<Bundle>(fallback);
  const [view, setView] = useState<View>(() => location.pathname === '/admin' ? 'admin' : 'cover');
  const [loading, setLoading] = useState(true);
  const [selected, setSelected] = useState(0);
  const [query, setQuery] = useState('');
  const [filter, setFilter] = useState('all');
  const [pageIndex, setPageIndex] = useState(-1);
  const [indexOpen, setIndexOpen] = useState(false);
  const [mobileNav, setMobileNav] = useState(false);
  const [loginOpen, setLoginOpen] = useState(false);
  const [admin, setAdmin] = useState(false);
  const [email, setEmail] = useState(''); const [password, setPassword] = useState('');
  const [authBusy, setAuthBusy] = useState(false); const [message, setMessage] = useState('');
  const [adminTab, setAdminTab] = useState<'cultures'|'pages'|'images'|'references'|'credits'>('cultures');
  const [editCulture, setEditCulture] = useState<Culture | null>(null);
  const [editPage, setEditPage] = useState<Page | null>(null);
  const [adminCulture, setAdminCulture] = useState('');
  const [photoFile, setPhotoFile] = useState<File | null>(null);
  const [photoEditId, setPhotoEditId] = useState('');
  const [photoPage, setPhotoPage] = useState('');
  const [photoUrl, setPhotoUrl] = useState('');
  const [photoCaption, setPhotoCaption] = useState(''); const [photoCredit, setPhotoCredit] = useState(''); const [photoSource, setPhotoSource] = useState('');
  const [referenceForm, setReferenceForm] = useState({ institution: '', title: '', url: '', note: '' });
  const [referenceEditId, setReferenceEditId] = useState('');
  const [creditForm, setCreditForm] = useState({ person_or_institution: '', role: '', text: '', source_url: '' });
  const [creditEditId, setCreditEditId] = useState('');

  const reload = useCallback(async () => {
    if (!supabase) { setBundle(fallback); setLoading(false); return; }
    setLoading(true);
    try {
      const [c, ch, p, im, rf, cr] = await Promise.all([
        supabase.from('cultures').select('*').order('sort_order'), supabase.from('chapters').select('*').order('sort_order'),
        supabase.from('pages').select('*').order('sort_order'), supabase.from('images').select('*').order('sort_order'),
        supabase.from('references').select('*').order('sort_order'), supabase.from('credits').select('*').order('created_at'),
      ]);
      const failure = [c,ch,p,im,rf,cr].find(x => x.error);
      if (failure?.error) throw failure.error;
      if (!c.data?.length) { setBundle(fallback); }
      else setBundle({ cultures: c.data as Culture[], chapters: (ch.data ?? []) as Chapter[], pages: (p.data ?? []) as Page[], images: (im.data ?? []) as ImageRecord[], references: (rf.data ?? []) as ReferenceRecord[], credits: (cr.data ?? []) as CreditRecord[] });
    } catch (e) { console.warn('Supabase indisponível; exibindo o acervo local incorporado.', e); setBundle(fallback); }
    finally { setLoading(false); }
  }, []);
  useEffect(() => { void reload(); }, [reload]);
  useEffect(() => {
    if (!supabase) return;
    void supabase.auth.getSession().then(async ({ data }) => {
      if (data.session) { const { data: ok } = await supabase!.rpc('is_admin'); setAdmin(Boolean(ok)); }
    });
    const { data } = supabase.auth.onAuthStateChange(async (_event, session) => {
      if (!session) setAdmin(false);
    });
    return () => data.subscription.unsubscribe();
  }, []);
  useEffect(() => { document.title = view === 'admin' ? 'Painel · Bestiário Cultural' : 'Bestiário Cultural — Arquivo vivo'; }, [view]);

  const cultures = bundle.cultures.filter(c => c.published || admin).sort((a,b)=>a.sort_order-b.sort_order);
  useEffect(() => { if (admin && !adminCulture && cultures[0]) setAdminCulture(cultures[0].id); }, [admin, adminCulture, cultures[0]?.id]);
  const culturePages = useMemo(() => cultures.flatMap(c => bundle.pages.filter(p => p.culture_id === c.id).sort((a,b)=>a.sort_order-b.sort_order).map(p => ({ culture: c, page: p }))), [cultures,bundle.pages]);
  const catalog = cultures.filter(c => (filter === 'all' || c.category === filter) && `${c.title} ${c.category_label} ${c.region} ${c.excerpt} ${c.subtitle} ${c.territorial_note} ${bundle.pages.filter(p=>p.culture_id===c.id).map(p=>p.title+' '+p.content).join(' ')} ${bundle.references.filter(r=>r.culture_id===c.id).map(r=>r.title+' '+r.institution+' '+r.note).join(' ')}`.toLocaleLowerCase('pt-BR').includes(query.toLocaleLowerCase('pt-BR')));
  const current = culturePages[pageIndex];
  const selectedCulture = cultures.find(c => c.id === adminCulture) ?? cultures[0];
  const navigate = (v: View) => { if (v === 'reader') setPageIndex(-1); setView(v); setMobileNav(false); setIndexOpen(false); history.pushState({}, '', v === 'admin' ? '/admin' : '/'); };
  useEffect(() => { const back = () => setView(location.pathname === '/admin' ? 'admin' : 'cover'); addEventListener('popstate',back); return () => removeEventListener('popstate',back); }, []);
  const openCulture = (culture: Culture) => { const i = culturePages.findIndex(x => x.culture.id === culture.id); setSelected(cultures.findIndex(c => c.id === culture.id)); setPageIndex(Math.max(i,0)); setView('reader'); history.pushState({}, '', '/'); setIndexOpen(false); window.scrollTo({top:0,behavior:'smooth'}); };
  const turn = (n: number) => setPageIndex(i => Math.max(-1,Math.min(culturePages.length-1,i+n)));
  useEffect(() => { const onKey = (e: KeyboardEvent) => { if (view !== 'reader' || /INPUT|TEXTAREA|SELECT/.test((e.target as HTMLElement)?.tagName)) return; if (e.key === 'ArrowLeft') turn(-1); if (e.key === 'ArrowRight') turn(1); if (e.key === 'Escape') { setLoginOpen(false); setIndexOpen(false); } }; window.addEventListener('keydown',onKey); return ()=>window.removeEventListener('keydown',onKey); }, [view,culturePages.length]);

  const login = async (e: React.FormEvent) => {
    e.preventDefault(); if (!supabase) { setMessage('Configure VITE_SUPABASE_URL e VITE_SUPABASE_ANON_KEY para ativar o login.'); return; }
    setAuthBusy(true); setMessage('');
    const { error } = await supabase.auth.signInWithPassword({ email, password });
    if (error) { setMessage(`Não foi possível entrar: ${error.message}`); setAuthBusy(false); return; }
    const { data, error: roleError } = await supabase.rpc('is_admin');
    if (roleError || !data) { await supabase.auth.signOut(); setMessage('Conta autenticada sem autorização de administração. Solicite a inclusão em admin_users.'); setAuthBusy(false); return; }
    setAdmin(true); setLoginOpen(false); setPassword(''); setView('admin'); history.pushState({},'','/admin'); setAdminCulture(cultures[0]?.id ?? ''); setMessage(''); setAuthBusy(false);
  };
  const logout = async () => { await supabase?.auth.signOut(); setAdmin(false); navigate('cover'); };
  const requireAdmin = () => { if (!supabaseReady) { setMessage('O login exige configuração de projeto Supabase.'); } else setLoginOpen(true); };
  const dbError = (e: unknown) => { setMessage(`Não foi possível salvar: ${err(e)}`); };
  const cleanupStorage = async (path: string | null | undefined) => {
    if (!supabase || !path) return;
    const { data, error } = await supabase.from('images').select('id').eq('storage_path', path).limit(1);
    if (error || data?.length) return;
    const { error: removeError } = await supabase.storage.from('bestiario-images').remove([path]);
    if (removeError) console.warn('Arquivo órfão no Storage; limpeza manual pode ser necessária.', removeError);
  };
  const syncCultureCover = async (cultureId: string, data: { title: string; cover_image_url: string; photo_credit: string; photo_source_url: string }) => {
    if (!supabase) return;
    const oldCover = bundle.images.find(i => i.culture_id === cultureId && i.page_id === null && i.url === editCulture?.cover_image_url);
    if (!data.cover_image_url) {
      if (oldCover) {
        const creditDelete = await supabase.from('credits').delete().eq('image_id', oldCover.id);
        if (creditDelete.error) throw creditDelete.error;
        const imageDelete = await supabase.from('images').delete().eq('id', oldCover.id);
        if (imageDelete.error) throw imageDelete.error;
        await cleanupStorage(oldCover.storage_path);
      }
      return;
    }
    const path = oldCover && oldCover.url === data.cover_image_url ? oldCover.storage_path : null;
    const imagePayload = {
      culture_id: cultureId, page_id: null, storage_path: path, url: data.cover_image_url,
      alt: `Imagem de ${data.title}`, caption: data.title,
      credit: data.photo_credit, source_url: data.photo_source_url, sort_order: oldCover?.sort_order ?? 0,
    };
    const saved = oldCover
      ? await supabase.from('images').update(imagePayload).eq('id', oldCover.id).select('id').single()
      : await supabase.from('images').insert(imagePayload).select('id').single();
    if (saved.error) throw saved.error;
    const linkedCredit = await supabase.from('credits').select('id').eq('image_id', saved.data.id).maybeSingle();
    if (linkedCredit.error) throw linkedCredit.error;
    if (linkedCredit.data || data.photo_credit || data.photo_source_url) {
      const creditPayload = {
        culture_id: cultureId, image_id: saved.data.id,
        person_or_institution: data.photo_credit || 'Atribuição não informada',
        role: 'Crédito da imagem',
        text: data.photo_credit ? 'Atribuição e licença conforme os dados editoriais cadastrados para esta imagem.' : 'Atribuição não informada no momento do cadastro.',
        source_url: data.photo_source_url,
      };
      const creditSave = linkedCredit.data
        ? await supabase.from('credits').update(creditPayload).eq('id', linkedCredit.data.id)
        : await supabase.from('credits').insert(creditPayload);
      if (creditSave.error) throw creditSave.error;
    }
    if (oldCover?.storage_path && oldCover.storage_path !== path) await cleanupStorage(oldCover.storage_path);
  };
  const saveCulture = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault(); if (!supabase || !admin) return;
    const f = new FormData(e.currentTarget); const title = String(f.get('title') ?? '').trim();
    const record = { slug: String(f.get('slug') || slugify(title)), title, category: String(f.get('category') || 'cultura'), category_label: String(f.get('category_label') || ''), region: String(f.get('region') || ''), subtitle: String(f.get('subtitle') || ''), excerpt: String(f.get('excerpt') || ''), story: String(f.get('story') || '').split('\n\n').filter(Boolean), territorial_note: String(f.get('territorial_note') || ''), visual_motif: String(f.get('visual_motif') || ''), cover_image_url: String(f.get('cover_image_url') || '').trim(), photo_credit: String(f.get('photo_credit') || '').trim(), photo_source_url: String(f.get('photo_source_url') || '').trim(), published: f.get('published') === 'on', sort_order: editCulture?.sort_order ?? cultures.length + 1 };
    try {
      const result = editCulture ? await supabase.from('cultures').update(record).eq('id', editCulture.id).select().single() : await supabase.from('cultures').insert(record).select().single();
      if (result.error) throw result.error;
      await syncCultureCover(result.data.id, record);
      if (editCulture) {
        const chapter = await supabase.from('chapters').update({ title, intro: record.excerpt }).eq('culture_id', editCulture.id);
        if (chapter.error) throw chapter.error;
      } else {
        const chapter = await supabase.from('chapters').insert({ culture_id: result.data.id, title, intro: record.excerpt, sort_order: record.sort_order }).select().single();
        if (chapter.error) throw chapter.error;
        const intro = record.story.length ? record.story : [record.excerpt].filter(Boolean);
        const html = intro.map(t => `<p>${t.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;')}</p>`).join('');
        if (html) {
          const firstPage = await supabase.from('pages').insert({ culture_id: result.data.id, chapter_id: chapter.data.id, title: 'Apresentação', label: 'Abertura do capítulo', content: html, sort_order: 1, is_extra: true });
          if (firstPage.error) throw firstPage.error;
        }
      }
      setEditCulture(null); setMessage('Cultura salva no Supabase.'); await reload();
    } catch (e) { dbError(e); }
  };
  const deleteCulture = async (culture: Culture) => { if (!supabase || !admin || !confirm(`Excluir “${culture.title}” e seu conteúdo?`)) return; const {error}=await supabase.from('cultures').delete().eq('id',culture.id); if(error) dbError(error); else {setMessage('Cultura excluída.');setEditCulture(null);await reload();} };
  const moveCulture = async (culture: Culture, delta: number) => { const list=[...cultures]; const i=list.findIndex(c=>c.id===culture.id), j=i+delta; if(j<0||j>=list.length||!supabase)return; [list[i],list[j]]=[list[j],list[i]]; try { for (const [n,c] of list.entries()) { const {error}=await supabase.from('cultures').update({sort_order:n+1}).eq('id',c.id); if(error)throw error; } await reload(); } catch(e){dbError(e);} };
  const savePage = async (e: React.FormEvent<HTMLFormElement>) => { e.preventDefault(); if(!supabase||!admin||!selectedCulture)return; const f=new FormData(e.currentTarget); const data={culture_id:selectedCulture.id,chapter_id:bundle.chapters.find(c=>c.culture_id===selectedCulture.id)?.id??null,title:String(f.get('title')||''),label:String(f.get('label')||''),content:String(f.get('content')||''),sort_order:editPage?.sort_order??(bundle.pages.filter(p=>p.culture_id===selectedCulture.id).length+1),is_extra:true}; try {const r=editPage?await supabase.from('pages').update(data).eq('id',editPage.id):await supabase.from('pages').insert(data);if(r.error)throw r.error;setEditPage(null);setMessage('Página salva.');await reload();}catch(e){dbError(e);} };
  const deletePage = async (page: Page) => {if(!supabase||!admin||!confirm(`Remover a página “${page.title}”?`))return;const {error}=await supabase.from('pages').delete().eq('id',page.id);if(error)dbError(error);else{setMessage('Página removida.');setEditPage(null);await reload();}};
  const movePage = async (page: Page, delta: number) => {if(!supabase||!admin)return;const list=bundle.pages.filter(p=>p.culture_id===page.culture_id).sort((a,b)=>a.sort_order-b.sort_order), i=list.findIndex(p=>p.id===page.id),j=i+delta;if(j<0||j>=list.length)return;[list[i],list[j]]=[list[j],list[i]];try{for(const [n,p]of list.entries()){const {error}=await supabase.from('pages').update({sort_order:-1000-n}).eq('id',p.id);if(error)throw error;}for(const [n,p]of list.entries()){const {error}=await supabase.from('pages').update({sort_order:n+1}).eq('id',p.id);if(error)throw error;}await reload();}catch(e){dbError(e);}};
  const addImage = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (!supabase || !admin || !selectedCulture) return;
    try {
      const old = bundle.images.find(i => i.id === photoEditId);
      let url = photoUrl.trim();
      let path = old && url === old.url ? old.storage_path : null;
      if (photoFile) {
        if (photoFile.size > 10 * 1024 * 1024) throw new Error('A imagem excede o limite de 10 MB.');
        path = `${selectedCulture.id}/${crypto.randomUUID()}-${photoFile.name.replace(/[^a-zA-Z0-9._-]/g, '_')}`;
        const upload = await supabase.storage.from('bestiario-images').upload(path, photoFile, { upsert: false, contentType: photoFile.type });
        if (upload.error) throw upload.error;
        url = supabase.storage.from('bestiario-images').getPublicUrl(path).data.publicUrl;
      }
      if (!url) throw new Error('Escolha uma imagem ou informe uma URL.');
      const payload = {
        culture_id: selectedCulture.id,
        page_id: photoPage || null,
        url,
        storage_path: path,
        alt: `Imagem de ${selectedCulture.title}`,
        caption: photoCaption,
        credit: photoCredit,
        source_url: photoSource,
        sort_order: old?.sort_order ?? bundle.images.filter(i => i.culture_id === selectedCulture.id).length,
      };
      const result = photoEditId
        ? await supabase.from('images').update(payload).eq('id', photoEditId).select('id').single()
        : await supabase.from('images').insert(payload).select('id').single();
      if (result.error) throw result.error;
      const creditRow = await supabase.from('credits').select('id').eq('image_id', result.data.id).maybeSingle();
      if (creditRow.error) throw creditRow.error;
      const creditPayload = {
        culture_id: selectedCulture.id,
        image_id: result.data.id,
        person_or_institution: photoCredit.trim() || 'Atribuição não informada',
        role: 'Crédito da imagem',
        text: photoCredit.trim() ? 'Atribuição e licença conforme os dados editoriais cadastrados para esta imagem.' : 'Atribuição não informada no momento do cadastro.',
        source_url: photoSource.trim(),
      };
      const creditSave = creditRow.data
        ? await supabase.from('credits').update(creditPayload).eq('id', creditRow.data.id)
        : await supabase.from('credits').insert(creditPayload);
      if (creditSave.error) throw creditSave.error;
      if (!photoPage) {
        const cover = await supabase.from('cultures').update({ cover_image_url: url, photo_credit: photoCredit, photo_source_url: photoSource }).eq('id', selectedCulture.id);
        if (cover.error) throw cover.error;
      }
      if (old?.storage_path && old.storage_path !== path) await cleanupStorage(old.storage_path);
      setPhotoUrl(''); setPhotoFile(null); setPhotoEditId(''); setPhotoPage(''); setPhotoCaption(''); setPhotoCredit(''); setPhotoSource('');
      setMessage(photoEditId ? 'Metadados da imagem atualizados.' : 'Imagem adicionada.');
      await reload();
    } catch (e) { dbError(e); }
  };
  const deleteImage = async (im: ImageRecord) => {
    if (!supabase || !admin || !confirm('Remover esta imagem do acervo?')) return;
    try {
      const { error: creditError } = await supabase.from('credits').delete().eq('image_id', im.id);
      if (creditError) throw creditError;
      const { error } = await supabase.from('images').delete().eq('id', im.id);
      if (error) throw error;
      if (im.page_id === null) {
        const c = bundle.cultures.find(c => c.id === im.culture_id);
        if (c?.cover_image_url === im.url) {
          const { error: coverError } = await supabase.from('cultures').update({ cover_image_url: '' }).eq('id', im.culture_id);
          if (coverError) throw coverError;
        }
      }
      await cleanupStorage(im.storage_path);
      await reload(); setMessage('Imagem removida.');
    } catch (e) { dbError(e); }
  };
  const addReference=async(e:React.FormEvent)=>{e.preventDefault();if(!supabase||!admin||!selectedCulture)return;try{const result=referenceEditId?await supabase.from('references').update(referenceForm).eq('id',referenceEditId):await supabase.from('references').insert({...referenceForm,culture_id:selectedCulture.id,sort_order:bundle.references.filter(r=>r.culture_id===selectedCulture.id).length+1});if(result.error)throw result.error;setReferenceForm({institution:'',title:'',url:'',note:''});setReferenceEditId('');await reload();setMessage('Referência salva.');}catch(e){dbError(e);}};
  const deleteReference=async(r:ReferenceRecord)=>{if(!supabase||!admin||!confirm('Excluir esta referência?'))return;const {error}=await supabase.from('references').delete().eq('id',r.id);if(error)dbError(error);else{await reload();setMessage('Referência excluída.');}};
  const addCredit=async(e:React.FormEvent)=>{e.preventDefault();if(!supabase||!admin||!selectedCulture)return;try{const result=creditEditId?await supabase.from('credits').update(creditForm).eq('id',creditEditId):await supabase.from('credits').insert({...creditForm,culture_id:selectedCulture.id});if(result.error)throw result.error;setCreditForm({person_or_institution:'',role:'',text:'',source_url:''});setCreditEditId('');await reload();setMessage('Crédito salvo.');}catch(e){dbError(e);}};
  const deleteCredit=async(c:CreditRecord)=>{if(!supabase||!admin||!confirm('Excluir este crédito?'))return;const {error}=await supabase.from('credits').delete().eq('id',c.id);if(error)dbError(error);else{await reload();setMessage('Crédito excluído.');}};

  const navItems: [View,string][] = [['cover','Início / Capa'],['reader','Livro digital'],['catalog','Catálogo'],['credits','Créditos']];
  const sourceCulture = current?.culture ?? cultures[0];
  const pageImages = current ? (() => { const specific = bundle.images.filter(i => i.culture_id === current.culture.id && i.page_id === current.page.id); if (specific.length) return specific; const cover = bundle.images.find(i => i.culture_id === current.culture.id && i.page_id === null && i.url === current.culture.cover_image_url); return cover ? [cover] : []; })() : [];
  const coverImage = sourceCulture?.cover_image_url || bundle.images.find(i=>i.culture_id===sourceCulture?.id)?.url || '';
  return <div className="app-shell">
    <header className="topbar"><button className="wordmark" onClick={()=>navigate('cover')} aria-label="Bestiário Cultural — capa"><span className="seal mini"><span>BC</span><i/><i/><i/><i/><i/><i/><i/><i/></span><span className="wordmark-title">Bestiário<small>Cultural · arquivo vivo</small></span></button>
      <button className="mobile-menu" onClick={()=>setMobileNav(v=>!v)} aria-label="Abrir menu">{mobileNav?<X/>:<Menu/>}</button>
      <nav className={mobileNav?'nav open':'nav'}>{navItems.map(([v,t])=><button key={v} className={view===v?'active':''} onClick={()=>navigate(v)}>{t}</button>)}</nav>
    </header>
    {view==='cover' && <main className="cover-view"><div className="cover-grain"/><div className="cover-layout"><div className="cover-book" style={coverImage?{'--cover-image':`url("${coverImage}")`} as React.CSSProperties:{}}><div className="book-border"/><div className="cover-symbol"><span className="seal large"><span>BC</span><i/><i/><i/><i/><i/><i/><i/><i/></span><small>Arquivo vivo · Brasil</small><span className="ornament-line"/><h1>Bestiário<br/><em>Cultural</em></h1><p>Acervo digital de manifestações populares da Paraíba e de Pernambuco</p><button className="gold-button" onClick={()=>navigate('reader')}><BookOpen size={17}/> Abrir o livro</button><small className="edition">Edição digital · cinco dossiês culturais</small></div></div>
        <aside className="cover-aside"><div className="eyebrow">Caderno de campo · Nordeste do Brasil</div><h2>Memórias que<br/><em>continuam vivas.</em></h2><p>Uma obra de consulta, escuta e reconhecimento. Percorra histórias, territórios e saberes transmitidos por comunidades e brincantes.</p><div className="cover-rule"/><div className="stats"><div><b>{cultures.length.toString().padStart(2,'0')}</b><span>culturas<br/>documentadas</span></div><div><b>{bundle.pages.length.toString().padStart(2,'0')}</b><span>páginas<br/>de pesquisa</span></div></div><button className="text-link" onClick={()=>navigate('catalog')}>Explorar o catálogo <ArrowRight size={16}/></button><p className="cover-footnote">Este arquivo preserva as fontes e os créditos apresentados no acervo de origem. As imagens devem ser reutilizadas respeitando sua licença original.</p></aside></div></main>}
    {view==='reader' && <main className="reader-view"><div className="section-heading"><span className="eyebrow">Leitura em movimento</span><h1>O livro das culturas</h1><p>Folheie os capítulos, consulte o índice e aproxime-se das histórias e dos territórios.</p></div><div className="reader-tools"><div className="reader-chapter">{current?<><span>CAPÍTULO {String(selected+1).padStart(2,'0')}</span><b>{current.culture.title}</b></>:<>ABERTURA · BESTIÁRIO CULTURAL</>}</div><div className="reader-actions"><button className={'outline-button '+(indexOpen?'selected':'')} onClick={()=>setIndexOpen(v=>!v)}><List size={16}/> Índice <ChevronDown size={14}/></button><button className="round-button" onClick={()=>turn(-1)} disabled={pageIndex<=-1} aria-label="Página anterior"><ChevronLeft/></button><button className="round-button" onClick={()=>turn(1)} disabled={pageIndex>=culturePages.length-1} aria-label="Próxima página"><ChevronRight/></button></div></div>
      {indexOpen&&<div className="index-panel"><div className="index-heading"><b>Índice dos capítulos</b><button onClick={()=>setIndexOpen(false)} aria-label="Fechar índice"><X size={18}/></button></div><button className="index-row" onClick={()=>{setPageIndex(-1);setIndexOpen(false)}}><span>00</span><span>Abertura · Como ler esta obra</span></button>{cultures.map((c,i)=><div className="index-group" key={c.id}><button className="index-row chapter-row" onClick={()=>openCulture(c)}><span>{String(i+1).padStart(2,'0')}</span><b>{c.title}</b><ArrowRight size={15}/></button>{bundle.pages.filter(p=>p.culture_id===c.id).sort((a,b)=>a.sort_order-b.sort_order).map(p=><button key={p.id} className="index-row sub-row" onClick={()=>{const n=culturePages.findIndex(x=>x.page.id===p.id);setPageIndex(Math.max(0,n));setSelected(i);setIndexOpen(false)}}>{p.title}</button>)}</div>)}</div>}
      <div className="book-frame"><button className="page-edge edge-left" onClick={()=>turn(-1)} aria-label="Voltar uma página"><ArrowLeft/></button><article className="page-sheet"><div className="page-left"><div className="page-topline">{current?current.page.label||`Caderno · ${current.culture.region}`:'ARQUIVO VIVO · BRASIL'}</div>{current?<><h2>{current.page.title}</h2><div className="rich-text" dangerouslySetInnerHTML={safeHtml(current.page.content)}/><div className="page-number">{String(pageIndex+1).padStart(3,'0')}</div></>:<><h2>Um livro para guardar<br/>as culturas</h2><p className="dropcap">Este Bestiário reúne cinco manifestações culturais em capítulos dedicados às suas histórias, territórios, gestos e comunidades. Cada registro é uma porta de entrada para pesquisa e reconhecimento de quem mantém vivas essas tradições.</p><p>Escolha uma manifestação no catálogo ou consulte o índice para iniciar a leitura.</p><div className="page-number">000</div></>}</div><div className="page-right">{current?<><div className="page-topline">{current.culture.category_label}</div>{pageImages.length>0?<div className="page-gallery">{pageImages.slice(0,2).map(im=><figure key={im.id}><img src={im.storage_path&&supabase?supabase.storage.from('bestiario-images').getPublicUrl(im.storage_path).data.publicUrl:im.url} alt={im.alt}/><figcaption>{im.caption} {im.credit&&`· ${im.credit}`}{im.source_url&&<> · <a href={im.source_url} target="_blank" rel="noreferrer">Fonte <ExternalLink size={10}/></a></>}</figcaption></figure>)}</div>:<><h3>{current.culture.title}</h3><p className="page-summary">{current.culture.excerpt}</p><div className="margin-note"><Feather size={15}/><span>{current.culture.territorial_note}</span></div>{bundle.references.filter(r=>r.culture_id===current.culture.id).slice(0,2).map(r=><p className="page-reference" key={r.id}><a href={r.url||'#'} target="_blank" rel="noreferrer">{r.institution} · {r.title}<ExternalLink size={11}/></a></p>)}</>}<div className="page-number">{String(pageIndex+2).padStart(3,'0')}</div></>:<><div className="page-topline">MEMÓRIA · TERRITÓRIO · CONTINUIDADE</div><div className="intro-mark"><span>✳</span></div><h3>Uma coleção de histórias</h3><p>Do teatro popular à roda, os capítulos se aproximam sem reduzir a diversidade de cada comunidade.</p><div className="intro-list">{cultures.map((c,i)=><button key={c.id} onClick={()=>openCulture(c)}><span>{String(i+1).padStart(2,'0')}</span>{c.title}<ArrowRight size={14}/></button>)}</div><div className="page-number">001</div></>}</div></article><button className="page-edge edge-right" onClick={()=>turn(1)} aria-label="Avançar uma página"><ArrowRight/></button></div><div className="reader-foot"><span>Use as setas do teclado ou as margens do livro para folhear.</span><b>PÁGINA {String(pageIndex+2).padStart(2,'0')} DE {String(culturePages.length+1).padStart(2,'0')}</b></div></main>}
    {view==='catalog'&&<main className="catalog-view"><div className="catalog-title"><div><span className="eyebrow">Inventário · cinco dossiês</span><h1>Catálogo de<br/><em>manifestações</em></h1><p>Procure por nome, território ou tema. Selecione um registro para abrir seu capítulo no livro.</p></div><div className="catalog-count"><b>{String(catalog.length).padStart(2,'0')}</b><small>registros</small></div></div><div className="catalog-controls"><label className="searchbox"><Search size={18}/><input value={query} onChange={e=>setQuery(e.target.value)} placeholder="Buscar cultura, região ou tema…" aria-label="Pesquisar catálogo"/></label><div className="filterbar"><Filter size={16}/>{[['all','Todas'],['danca','Dança e jogo'],['festa','Folguedos']].map(([id,label])=><button key={id} className={filter===id?'active':''} onClick={()=>setFilter(id)}>{label}</button>)}</div></div><div className="catalog-grid">{catalog.map((c,i)=>{const photo=c.cover_image_url||bundle.images.find(x=>x.culture_id===c.id)?.url;return <article className="catalog-card" key={c.id}><div className="card-meta"><span>{String(i+1).padStart(2,'0')}</span><span>{c.category_label}</span></div><button className="photo-button" onClick={()=>openCulture(c)} aria-label={`Abrir ${c.title}`}>{photo?<img src={photo} alt={`Imagem de ${c.title}`} loading="lazy"/>:<span className="photo-placeholder"><Sparkles/></span>}</button><div className="card-copy"><span className="region-label">{c.region}</span><h2>{c.title}</h2><p>{c.excerpt}</p><button className="card-link" onClick={()=>openCulture(c)}>Abrir capítulo <ArrowRight size={15}/></button></div></article>})}{catalog.length===0&&<p className="no-results">Nenhum registro corresponde à busca. Tente outros termos.</p>}</div></main>}
    {view==='credits'&&<main className="credits-view"><div className="section-heading"><span className="eyebrow">Caderno de fontes</span><h1>Créditos e referências</h1><p>As sínteses e atribuições foram preservadas do documento de origem. Consulte as instituições e referências para aprofundar a pesquisa.</p></div><div className="credits-list">{cultures.map((c,i)=><article className="credit-card" key={c.id}><div className="credit-number">{String(i+1).padStart(2,'0')}</div><div><span className="eyebrow">{c.region}</span><h2>{c.title}</h2><p className="image-attribution">Fotografia/imagem: {c.photo_credit||'crédito conforme fonte original'} {c.photo_source_url&&<a href={c.photo_source_url} target="_blank" rel="noreferrer">Ver origem <ExternalLink size={12}/></a>}</p>{bundle.credits.filter(x=>x.culture_id===c.id).map(x=><p className="image-attribution" key={x.id}><b>{x.person_or_institution}</b> · {x.role}. {x.text} {x.source_url&&<a href={x.source_url} target="_blank" rel="noreferrer">Fonte <ExternalLink size={12}/></a>}</p>)}<ul>{bundle.references.filter(r=>r.culture_id===c.id).map(r=><li key={r.id}><span>{r.institution}</span> · {r.url&&r.url!=='#'?<a href={r.url} target="_blank" rel="noreferrer">{r.title}<ExternalLink size={11}/></a>:<b>{r.title}</b>}<small>{r.note}</small></li>)}</ul></div></article>)}</div><p className="license-note">Os endereços de imagens presentes no documento de origem foram preservados. Confirme licença, autoria e condições de reutilização junto à instituição ou ao arquivo antes de republicar.</p></main>}
    {view==='admin'&&<main className="admin-view"><div className="admin-heading"><div><span className="eyebrow">Área restrita · Supabase Auth</span><h1>Painel do acervo</h1><p>Gerencie os registros e publique alterações persistentes para todos os visitantes.</p></div>{admin?<button className="outline-button" onClick={()=>void logout()}><LogOut size={16}/> Sair</button>:<button className="gold-button" onClick={requireAdmin}><LogIn size={17}/> Entrar como administradora(o)</button>}</div>
      {!admin?<div className="admin-gate"><ShieldCheck size={30}/><h2>Acesso autenticado</h2><p>Entre com uma conta criada no Supabase Auth e autorizada na tabela administrativa. A identidade não é armazenada no código do site.</p><button className="outline-button" onClick={requireAdmin}>Abrir login <ArrowRight size={15}/></button><div className="setup-callout">{supabaseReady?'O Supabase está configurado. A primeira conta deve ser promovida seguindo o README.':'Modo de leitura local ativo — configure as variáveis de ambiente para conectar o Supabase.'}</div></div>:<>
      <div className="admin-statusbar"><span><span className="status-dot"/> Sessão autorizada · persistência Supabase</span><button onClick={()=>void reload()}>Atualizar acervo</button></div>
      <div className="admin-workspace"><aside className="admin-sidebar"><label>CULTURA EM EDIÇÃO<select value={adminCulture} onChange={e=>{setAdminCulture(e.target.value);setEditCulture(null);setEditPage(null)}}>{cultures.map(c=><option key={c.id} value={c.id}>{c.title}</option>)}</select></label>{([['cultures','Culturas'],['pages','Páginas do livro'],['images','Imagens'],['references','Referências'],['credits','Créditos']] as const).map(([k,label])=><button key={k} className={adminTab===k?'active':''} onClick={()=>{setAdminTab(k);setMessage('')}}>{label}</button>)}</aside><section className="admin-content">
        {adminTab==='cultures'&&<><div className="admin-section-head"><div><span className="eyebrow">Acervo cultural</span><h2>{editCulture?'Editar cultura': 'Culturas'}</h2></div><button className="gold-button compact" onClick={()=>setEditCulture({id:'',slug:'',title:'',category:'danca',category_label:'Manifestação cultural',region:'',subtitle:'',excerpt:'',story:[],territorial_note:'',visual_motif:'',cover_image_url:'',photo_credit:'',photo_source_url:'',sort_order:cultures.length+1,published:true})}>＋ Nova cultura</button></div>
          {editCulture?<form className="admin-form" onSubmit={saveCulture}><div className="form-two"><label>Nome<input name="title" defaultValue={editCulture.title} required/></label><label>Slug<input name="slug" defaultValue={editCulture.slug} placeholder="gerado-do-nome"/></label><label>Categoria<select name="category" defaultValue={editCulture.category}><option value="danca">Dança e jogo</option><option value="festa">Folguedos</option><option value="cultura">Cultura</option></select></label><label>Rótulo de categoria<input name="category_label" defaultValue={editCulture.category_label}/></label><label>Região<input name="region" defaultValue={editCulture.region}/></label><label>Subtítulo<input name="subtitle" defaultValue={editCulture.subtitle}/></label><label className="wide">Resumo<input name="excerpt" defaultValue={editCulture.excerpt}/></label><label className="wide">História (parágrafos separados por linha em branco)<textarea name="story" defaultValue={editCulture.story.join('\n\n')} rows={5}/></label><label className="wide">Nota territorial<textarea name="territorial_note" defaultValue={editCulture.territorial_note}/></label><label>Motivo visual<input name="visual_motif" defaultValue={editCulture.visual_motif}/></label><label>URL da capa<input name="cover_image_url" defaultValue={editCulture.cover_image_url} type="url"/></label><label>Crédito da imagem<input name="photo_credit" defaultValue={editCulture.photo_credit}/></label><label>Fonte da imagem<input name="photo_source_url" defaultValue={editCulture.photo_source_url} type="url"/></label><label className="check-line"><input name="published" type="checkbox" defaultChecked={editCulture.published}/> Publicado</label></div><div className="form-actions"><button className="gold-button compact">Salvar cultura</button><button type="button" className="outline-button" onClick={()=>setEditCulture(null)}>Cancelar</button></div></form>:<div className="manage-list">{cultures.map((c,i)=><div className="manage-row" key={c.id}><span className="order-controls"><button onClick={()=>void moveCulture(c,-1)} disabled={i===0}>↑</button><button onClick={()=>void moveCulture(c,1)} disabled={i===cultures.length-1}>↓</button></span><div className="manage-title"><b>{c.title}</b><small>{c.region} · {c.published?'Publicado':'Rascunho'}</small></div><button className="small-action" onClick={()=>setEditCulture(c)}>Editar</button><button className="small-action danger" onClick={()=>void deleteCulture(c)}>Excluir</button></div>)}</div>}</>}
        {adminTab==='pages'&&<><div className="admin-section-head"><div><span className="eyebrow">Capítulos · até 40 páginas extras</span><h2>Páginas</h2></div><button className="gold-button compact" onClick={()=>setEditPage({id:'',culture_id:adminCulture,chapter_id:null,title:'',label:'Caderno de campo',content:'',sort_order:bundle.pages.filter(p=>p.culture_id===adminCulture).length+1,is_extra:true})} disabled={bundle.pages.filter(p=>p.culture_id===adminCulture).length>=40}>＋ Nova página</button></div>{bundle.pages.filter(p=>p.culture_id===adminCulture).length>=40&&<p className="warning-note">Limite de 40 páginas extras desta cultura atingido.</p>}{editPage&&<form className="admin-form" onSubmit={savePage}><div className="form-two"><label>Título<input name="title" defaultValue={editPage.title} required/></label><label>Identificação / capítulo<input name="label" defaultValue={editPage.label}/></label><label className="wide">Texto (permite HTML simples, higienizado ao exibir)<textarea name="content" defaultValue={editPage.content} rows={12}/></label></div><div className="form-actions"><button className="gold-button compact">Salvar página</button><button type="button" className="outline-button" onClick={()=>setEditPage(null)}>Cancelar</button></div></form>}<div className="manage-list">{bundle.pages.filter(p=>p.culture_id===adminCulture).sort((a,b)=>a.sort_order-b.sort_order).map((p,i)=><div className="manage-row" key={p.id}><span className="order-controls"><button onClick={()=>void movePage(p,-1)} disabled={i===0}>↑</button><button onClick={()=>void movePage(p,1)} disabled={i===bundle.pages.filter(x=>x.culture_id===adminCulture).length-1}>↓</button></span><div className="manage-title"><b>{p.title}</b><small>{p.label||'Página complementar'}</small></div><button className="small-action" onClick={()=>setEditPage(p)}>Editar</button><button className="small-action danger" onClick={()=>void deletePage(p)}>Excluir</button></div>)}</div></>}
        {adminTab==='images'&&<><div className="admin-section-head"><div><span className="eyebrow">Acervo visual · Supabase Storage</span><h2>Imagens</h2></div></div><form className="admin-form" onSubmit={addImage}><div className="form-two"><label className="wide">Enviar arquivo <span className="hint">JPEG, PNG, WebP ou AVIF · até 10 MB</span><input type="file" accept="image/jpeg,image/png,image/webp,image/avif" onChange={e=>setPhotoFile(e.target.files?.[0]??null)}/></label><label className="wide">Ou cadastrar URL<input type="url" value={photoUrl} onChange={e=>setPhotoUrl(e.target.value)} placeholder="https://…"/></label><label className="wide">Vincular a página (opcional)<select value={photoPage} onChange={e=>setPhotoPage(e.target.value)}><option value="">Imagem de capa / galeria da cultura</option>{bundle.pages.filter(p=>p.culture_id===adminCulture).map(p=>{const count=bundle.images.filter(i=>i.page_id===p.id&&i.id!==photoEditId).length;return <option key={p.id} value={p.id} disabled={count>=2}>{p.title}{count>=2?' · limite de duas imagens atingido':''}</option>})}</select></label><label className="wide">Legenda<input value={photoCaption} onChange={e=>setPhotoCaption(e.target.value)}/></label><label>Crédito / autoria<input value={photoCredit} onChange={e=>setPhotoCredit(e.target.value)}/></label><label>URL da fonte/licença<input type="url" value={photoSource} onChange={e=>setPhotoSource(e.target.value)}/></label></div><div className="form-actions"><button type="submit" className="gold-button compact"><Upload size={15}/> {photoEditId?'Salvar alterações':'Adicionar imagem'}</button>{photoEditId&&<button type="button" className="outline-button" onClick={()=>{setPhotoEditId('');setPhotoUrl('');setPhotoFile(null);setPhotoPage('');setPhotoCaption('');setPhotoCredit('');setPhotoSource('')}}>Cancelar edição</button>}</div></form><div className="image-admin-grid">{bundle.images.filter(i=>i.culture_id===adminCulture).map(im=><article key={im.id}><img src={im.storage_path&&supabase?supabase.storage.from('bestiario-images').getPublicUrl(im.storage_path).data.publicUrl:im.url} alt={im.alt}/><div><b>{im.caption||im.alt}</b><small>{im.credit}{im.page_id?` · ${bundle.pages.find(p=>p.id===im.page_id)?.title??'página vinculada'}`:' · capa/galeria'}</small>{im.source_url&&<a href={im.source_url} target="_blank" rel="noreferrer">Ver fonte</a>}<button className="small-action" onClick={()=>{setPhotoEditId(im.id);setPhotoUrl(im.url);setPhotoPage(im.page_id??'');setPhotoCaption(im.caption);setPhotoCredit(im.credit);setPhotoSource(im.source_url);setPhotoFile(null);}}>Editar legenda/crédito/fonte</button><button className="small-action danger" onClick={()=>void deleteImage(im)}>Remover</button></div></article>)}</div></>}
        {adminTab==='references'&&<><div className="admin-section-head"><div><span className="eyebrow">Fontes de pesquisa</span><h2>Referências</h2></div></div><form className="admin-form" onSubmit={addReference}><div className="form-two"><label>Instituição<input value={referenceForm.institution} onChange={e=>setReferenceForm({...referenceForm,institution:e.target.value})}/></label><label>Título<input value={referenceForm.title} onChange={e=>setReferenceForm({...referenceForm,title:e.target.value})} required/></label><label className="wide">URL<input type="url" value={referenceForm.url} onChange={e=>setReferenceForm({...referenceForm,url:e.target.value})}/></label><label className="wide">Nota<textarea value={referenceForm.note} onChange={e=>setReferenceForm({...referenceForm,note:e.target.value})}/></label></div><div className="form-actions"><button className="gold-button compact">{referenceEditId?'Salvar referência':'＋ Adicionar referência'}</button>{referenceEditId&&<button type="button" className="outline-button" onClick={()=>{setReferenceEditId('');setReferenceForm({institution:'',title:'',url:'',note:''})}}>Cancelar</button>}</div></form><div className="manage-list">{bundle.references.filter(r=>r.culture_id===adminCulture).map(r=><div className="manage-row ref-row" key={r.id}><div className="manage-title"><b>{r.institution} · {r.title}</b><small>{r.url||r.note}</small></div><button className="small-action" onClick={()=>{setReferenceEditId(r.id);setReferenceForm({institution:r.institution,title:r.title,url:r.url,note:r.note})}}>Editar</button><button className="small-action danger" onClick={()=>void deleteReference(r)}>Excluir</button></div>)}</div></>}
        {adminTab==='credits'&&<><div className="admin-section-head"><div><span className="eyebrow">Autoria e atribuição</span><h2>Créditos</h2></div></div><form className="admin-form" onSubmit={addCredit}><div className="form-two"><label>Pessoa ou instituição<input value={creditForm.person_or_institution} onChange={e=>setCreditForm({...creditForm,person_or_institution:e.target.value})} required/></label><label>Função no crédito<input value={creditForm.role} onChange={e=>setCreditForm({...creditForm,role:e.target.value})}/></label><label className="wide">Descrição / licença<textarea value={creditForm.text} onChange={e=>setCreditForm({...creditForm,text:e.target.value})}/></label><label className="wide">URL da fonte<input type="url" value={creditForm.source_url} onChange={e=>setCreditForm({...creditForm,source_url:e.target.value})}/></label></div><div className="form-actions"><button className="gold-button compact">{creditEditId?'Salvar crédito':'＋ Adicionar crédito'}</button>{creditEditId&&<button type="button" className="outline-button" onClick={()=>{setCreditEditId('');setCreditForm({person_or_institution:'',role:'',text:'',source_url:''})}}>Cancelar</button>}</div></form><div className="manage-list">{bundle.credits.filter(c=>c.culture_id===adminCulture).map(c=><div className="manage-row ref-row" key={c.id}><div className="manage-title"><b>{c.person_or_institution} · {c.role}</b><small>{c.text}</small></div><button className="small-action" onClick={()=>{setCreditEditId(c.id);setCreditForm({person_or_institution:c.person_or_institution,role:c.role,text:c.text,source_url:c.source_url})}}>Editar</button><button className="small-action danger" onClick={()=>void deleteCredit(c)}>Excluir</button></div>)}</div></>}
      </section></div></>}
      {message&&<p className="toast-message" role="status">{message}<button onClick={()=>setMessage('')} aria-label="Dispensar"><X size={15}/></button></p>}
    </main>}
    <footer className="footer"><span><b>BC</b> · Bestiário Cultural · arquivo vivo</span><span>Paraíba · Pernambuco · Brasil</span><button className="admin-trigger" onClick={()=>{setView('admin');history.pushState({},'','/admin');setMessage('')}}><ShieldCheck size={14}/> Administração</button></footer>
    {loginOpen&&<div className="modal-scrim" onMouseDown={e=>{if(e.target===e.currentTarget)setLoginOpen(false)}}><form className="login-modal" onSubmit={login}><button type="button" className="modal-close" onClick={()=>setLoginOpen(false)} aria-label="Fechar"><X/></button><span className="eyebrow">Área restrita</span><h2>Entrar no acervo</h2><p>Use suas credenciais do Supabase Auth.</p><label>E-mail<input type="email" autoComplete="username" value={email} onChange={e=>setEmail(e.target.value)} required/></label><label>Senha<input type="password" autoComplete="current-password" value={password} onChange={e=>setPassword(e.target.value)} required/></label>{message&&<div className="login-error">{message}</div>}<button className="gold-button" disabled={authBusy}>{authBusy?'Verificando…':'Entrar com segurança'}</button><small>O acesso de administração também depende de autorização explícita no banco de dados.</small></form></div>}
    {loading&&<div className="loading-indicator" aria-live="polite">Abrindo o arquivo…</div>}
  </div>;
}

createRoot(document.getElementById('root')!).render(<React.StrictMode><App/></React.StrictMode>);
