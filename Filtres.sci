//Filtres
//Black and white
function image = color2bw(M)
    R = M(:,:,1)
    G = M(:,:,2)
    B = M(:,:,3)
    image = imlincomb(0.299,R,0.587,G,0.114,B)
    imshow(image);
endfunction

//Original
function image = originale(M)
    image = M
    imshow(image);
endfunction

//Negative
function image = reverse(M)
    image = 255-M
    imshow(image);
endfunction

//Flip vertical
function image = flip_ver(M)
    [x,y,c] = size(M)
	for i = 1 : x/2+1
		for j = 1 : y
			image(i,j,:) = matrix(M(x-i+1,j,:),1,c)
			image(x-i+1,j,:) = matrix(M(i,j,:),1,c)
		end 
	end
    imshow(image);
endfunction

//Flip horizontal
function image = flip_hor(M)
    [x,y,c] = size(M)
		for i = 1 : x
			for j = 1 : y/2+1
				image(i,j,:) = matrix(M(i,y-j+1,:),1,c)
				image(i,y-j+1,:) = matrix(M(i,j,:),1,c)
			end
		end
    imshow(image);
endfunction

//Passe bas
function image = flou(M)
    img = fspecial('gaussian', 27, 3);
    image = imfilter(M, img);
    imshow(image);
endfunction

//Passe haut
function image = sobel(M)
    M = color2bw(M)
    image = edge(M, 'sobel')
    imshow(image);
endfunction

function image = prewitt(M)
    M = color2bw(M)
    image = edge(M, 'prewitt')
    imshow(image);
endfunction


//Format d'image accepté
formatSupported = ["*.PNG";"*.JPEG";"*.JPE*";"*.BMP*";"*.DIB*";"*.JPG*"]
//Variable choix Image
choix = " Aucun fichier sélectionné"
//Variable taille fenetre
largeur =550
longueur =450
//Fenetre
function[]=fenetre(f)
test=null()
f.axes_size =[largeur longueur]
//Titre
titre = uicontrol(f, "style", "text", ...
    "string", "Filtres", ...
    "fontsize", 40, ...
    "FontWeight", "bold", ...
    "FontAngle", "oblique", ...
    "ForegroundColor", [0,0.4,1], ... //1 0.3 0.3
    "HorizontalAlignment", "center", ...
    "position", [largeur/2-245/2 longueur-40 245 45]),
    "backgroundcolor", [1,0.3,0.3];
    
//Choix Image
choixImageText = uicontrol(f, "style", "text", ...
    "string", "Veuillez séléctionner l''image :", ...
    "fontsize", 15, ...
    "position", [10 longueur-70 195 20]);
choixActuelText = uicontrol(f, "style", "text", ...
    "string", "Choix :", ...
    "fontsize", 14, ...
    "position", [5 longueur-95 50 16]);
choixActuelText2 = uicontrol(f, "style", "text", ...
    "string", choix, ...
    "fontsize", 14, ...
    "position", [55 longueur-95 largeur-60 16]);
choixButton = uicontrol(f, "style", "pushbutton", ...
    "string", "Importer", ...
    "position", [220 longueur-72 180 20], ...
    "callback", "choix = uigetfile(formatSupported);close(f);f = createWindow();fenetre(f)");
//Execution
Original = uicontrol(f, "style", "pushbutton", ...
    "string", "Originale", ...
    "position", [largeur/2-60 10 130 30], ...
    "FontWeight", "bold", ...
    "callback", "originale(imread(choix))");
Black_and_white = uicontrol(f, "style", "pushbutton", ...
    "string", "Noir et Blanc", ...
    "position", [largeur/2-60 50 130 30], ...
    "FontWeight", "bold", ...
    "callback", "color2bw(imread(choix))");
Negative = uicontrol(f, "style", "pushbutton", ...
    "string", "Inverser", ...
    "position", [largeur/2-60 90 130 30], ... //y, x, largeur du carré, grandeur du carré
    "FontWeight", "bold", ...
    "callback", "reverse(imread(choix))");
Rotate_ver = uicontrol(f, "style", "pushbutton", ...
    "string", "Verticale", ...
    "position", [largeur/2-60 130 130 30], ... //y, x, largeur du carré, grandeur du carré
    "FontWeight", "bold", ...
    "callback", "flip_ver(imread(choix))");
Rotate_hor = uicontrol(f, "style", "pushbutton", ...
    "string", "Horizontale", ...
    "position", [largeur/2-60 170 130 30], ... //y, x, largeur du carré, grandeur du carré
    "FontWeight", "bold", ...
    "callback", "flip_hor(imread(choix))");
Contour = uicontrol(f, "style", "pushbutton", ...
    "string", "Sobel", ...
    "position", [largeur/2-60 210 130 30], ... //y, x, largeur du carré, grandeur du carré
    "FontWeight", "bold", ...
    "callback", "sobel(imread(choix))");
Blurry = uicontrol(f, "style", "pushbutton", ...
    "string", "Floue", ...
    "position", [largeur/2-60 250 130 30], ... //y, x, largeur du carré, grandeur du carré
    "FontWeight", "bold", ...
    "callback", "flou(imread(choix))");
Contour2 = uicontrol(f, "style", "pushbutton", ...
    "string", "Prewitt", ...
    "position", [largeur/2-60 290 130 30], ... //y, x, largeur du carré, grandeur du carré
    "FontWeight", "bold", ...
    "callback", "prewitt(imread(choix))");
endfunction

//creerfenetre
f = createWindow();
clf();
fenetre(f);
