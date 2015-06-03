importfrom ("std", "iconv", NULL, &on_eval_err);

loadfrom ("file", "copyfile", NULL, &on_eval_err);
loadfrom ("dir", "fswalk", NULL, &on_eval_err);
loadfrom ("stdio", "writefile", NULL, &on_eval_err);

variable
  BLACKLIST = [
    174, 238, 302, 366, 430, 494, 558, 622, 686, 750, 814, 878, 942, 1006, 1070, 1134,
    1152, 1153, 1154, 1155, 1156, 1157, 1158, 1159, 1160, 1161, 1162, 1163, 1164, 1165,
    1166, 1167, 1168, 1169, 1170, 1171, 1172, 1173, 1174, 1175, 1176, 1177, 1178, 1179,
    1180, 1181, 1182, 1183, 1184, 1185, 1186, 1187, 1188, 1189, 1190, 1191, 1192, 1193,
    1194, 1195, 1196, 1197, 1198, 1199, 1200, 1201, 1202, 1203, 1204, 1205, 1206, 1207,
    1208, 1209, 1210, 1211, 1212, 1213, 1214, 1215, 1262, 1326, 1390, 1454, 1518, 1582,
    1646, 1710, 1774, 1838, 1902, 1966, 2030, 2094, 2158, 2222, 2286, 2350, 2414, 2478,
    2542, 2606, 2670, 2734, 2798, 2862, 2926, 2944, 2945, 2946, 2947, 2948, 2949, 2950,
    2951, 2952, 2953, 2954, 2955, 2956, 2957, 2958, 2959, 2960, 2961, 2962, 2963, 2964,
    2965, 2966, 2967, 2968, 2969, 2970, 2971, 2972, 2973, 2974, 2975, 2976, 2977, 2978,
    2979, 2980, 2981, 2982, 2983, 2984, 2985, 2986, 2987, 2988, 2989, 2990, 2991, 2992,
    2993, 2994, 2995, 2996, 2997, 2998, 2999, 3000, 3001, 3002, 3003, 3004, 3005, 3006,
    3007, 3054, 3118, 3182, 3246, 3310, 3374, 3438, 3502, 3566, 3630, 3694, 3758, 3822,
    3886, 3950, 4014, 4078, 4142, 4206, 4270, 4334, 4398, 4462, 4526, 4590, 4654, 4718,
    4782, 4846, 4910, 4974, 5038, 5102, 5166, 5230, 5294, 5358, 5422, 5486, 5550, 5614,
    5678, 5742, 5806, 5870, 5934, 5998, 6062, 6126, 6190, 6254, 6318, 6382, 6446, 6510,
    6574, 6638, 6702, 6766, 6830, 6894, 6958, 7022, 7040, 7041, 7042, 7043, 7044, 7045,
    7046, 7047, 7048, 7049, 7050, 7051, 7052, 7053, 7054, 7055, 7056, 7057, 7058, 7059,
    7060, 7061, 7062, 7063, 7064, 7065, 7066, 7067, 7068, 7069, 7070, 7071, 7072, 7073,
    7074, 7075, 7076, 7077, 7078, 7079, 7080, 7081, 7082, 7083, 7084, 7085, 7086, 7087,
    7088, 7089, 7090, 7091, 7092, 7093, 7094, 7095, 7096, 7097, 7098, 7099, 7100, 7101,
    7102, 7103, 7150, 7214, 7278, 7342, 7406, 7470, 7534, 7598, 7662, 7726, 7790, 7854,
    7918, 7982, 8046, 8110, 8174, 8238, 8302, 8366, 8430, 8494, 8558, 8622, 8686, 8750,
    8814, 8878, 8942, 9006, 9070, 9134, 9198, 9262, 9326, 9390, 9454, 9518, 9582, 9646,
    9710, 9774, 9838, 9902, 9966, 10030, 10094, 10158, 10222, 10286, 10350, 10414, 10478,
    10542, 10606, 10670, 10734, 10798, 10862, 10926, 10990, 11054, 11118, 11136, 11137,
    11138, 11139, 11140, 11141, 11142, 11143, 11144, 11145, 11146, 11147, 11148, 11149,
    11150, 11151, 11152, 11153, 11154, 11155, 11156, 11157, 11158, 11159, 11160, 11161,
    11162, 11163, 11164, 11165, 11166, 11167, 11168, 11169, 11170, 11171, 11172, 11173,
    11174, 11175, 11176, 11177, 11178, 11179, 11180, 11181, 11182, 11183, 11184, 11185,
    11186, 11187, 11188, 11189, 11190, 11191, 11192, 11193, 11194, 11195, 11196, 11197,
    11198, 11199, 11246, 11310, 11374, 11438, 11502, 11566, 11630, 11694, 11758, 11822,
    11886, 11950, 12014, 12078, 12142, 12206, 12270, 12334, 12398, 12462, 12526, 12590,
    12654, 12718, 12782, 12846, 12910, 12974, 13038, 13102, 13166, 13230, 13294, 13358,
    13422, 13486, 13550, 13614, 13678, 13742, 13806, 13870, 13934, 13998, 14062, 14126,
    14190, 14254, 14318, 14382, 14446, 14510, 14574, 14638, 14702, 14766, 14830, 14894,
    14958, 15022, 15086, 15150, 15214, 15232, 15233, 15234, 15235, 15236, 15237, 15238,
    15239, 15240, 15241, 15242, 15243, 15244, 15245, 15246, 15247, 15248, 15249, 15250,
    15251, 15252, 15253, 15254, 15255, 15256, 15257, 15258, 15259, 15260, 15261, 15262,
    15263, 15264, 15265, 15266, 15267, 15268, 15269, 15270, 15271, 15272, 15273, 15274,
    15275, 15276, 15277, 15278, 15279, 15280, 15281, 15282, 15283, 15284, 15285, 15286,
    15287, 15288, 15289, 15290, 15291, 15292, 15293, 15294, 15295, 15342, 15406, 15470,
    15534, 15598, 15662, 15726, 15790, 15854, 15918, 15982, 16046, 16110, 16174, 16238,
    16302, 16366, 16430, 16494, 16558, 16622, 16686, 16750, 16814, 16878, 16942, 17006,
    17070, 17134, 17198, 17262, 17326, 17390, 17454, 17518, 17582, 17646, 17710, 17774,
    17838, 17902, 17966, 18030, 18094, 18158, 18222, 18286, 18350, 18414, 18478, 18542,
    18606, 18670, 18734, 18798, 18862, 18926, 18990, 19054, 19118, 19182, 19246, 19310,
    19328, 19329, 19330, 19331, 19332, 19333, 19334, 19335, 19336, 19337, 19338, 19339,
    19340, 19341, 19342, 19343, 19344, 19345, 19346, 19347, 19348, 19349, 19350, 19351,
    19352, 19353, 19354, 19355, 19356, 19357, 19358, 19359, 19360, 19361, 19362, 19363,
    19364, 19365, 19366, 19367, 19368, 19369, 19370, 19371, 19372, 19373, 19374, 19375,
    19376, 19377, 19378, 19379, 19380, 19381, 19382, 19383, 19384, 19385, 19386, 19387,
    19388, 19389, 19390, 19391, 19438, 19502, 19566, 19630, 19694, 19758, 19822, 19886,
    19950, 20014, 20078, 20142, 20206, 20270, 20334, 20398, 20462, 20526, 20590, 20654,
    20718, 20782, 20846, 20910, 20974, 21038, 21102, 21166, 21230, 21294, 21358, 21422,
    21486, 21550, 21614, 21678, 21742, 21806, 21870, 21934, 21998, 22062, 22126, 22190,
    22254, 22318, 22382, 22446, 22510, 22574, 22638, 22702, 22766, 22830, 22894, 22958,
    23022, 23086, 23150, 23214, 23278, 23342, 23406, 23424, 23425, 23426, 23427, 23428,
    23429, 23430, 23431, 23432, 23433, 23434, 23435, 23436, 23437, 23438, 23439, 23440,
    23441, 23442, 23443, 23444, 23445, 23446, 23447, 23448, 23449, 23450, 23451, 23452,
    23453, 23454, 23455, 23456, 23457, 23458, 23459, 23460, 23461, 23462, 23463, 23464,
    23465, 23466, 23467, 23468, 23469, 23470, 23471, 23472, 23473, 23474, 23475, 23476,
    23477, 23478, 23479, 23480, 23481, 23482, 23483, 23484, 23485, 23486, 23487, 23534,
    23598, 23662, 23726, 23790, 23854, 23918, 23982, 24046, 24110, 24174, 24238, 24302,
    24366, 24430, 24494, 24558, 24622, 24686, 24750, 24814, 24878, 24942, 25006, 25070,
    25134, 25198, 25262, 25326, 25390, 25454, 25518, 25582, 25646, 25710, 25774, 25838,
    25902, 25966, 26030, 26094, 26158, 26222, 26286, 26350, 26414, 26478, 26542, 26606,
    26670, 26734, 26798, 26862, 26926, 26990, 27054, 27118, 27182, 27246, 27310, 27374,
    27438, 27502, 27520, 27521, 27522, 27523, 27524, 27525, 27526, 27527, 27528, 27529,
    27530, 27531, 27532, 27533, 27534, 27535, 27536, 27537, 27538, 27539, 27540, 27541,
    27542, 27543, 27544, 27545, 27546, 27547, 27548, 27549, 27550, 27551, 27552, 27553,
    27554, 27555, 27556, 27557, 27558, 27559, 27560, 27561, 27562, 27563, 27564, 27565,
    27566, 27567, 27568, 27569, 27570, 27571, 27572, 27573, 27574, 27575, 27576, 27577,
    27578, 27579, 27580, 27581, 27582, 27583, 27630, 27694, 27758, 27822, 27886, 27950,
    28014, 28078, 28142, 28206, 28270, 28334, 28398, 28462, 28526, 28590, 28654, 28718,
    28782, 28846, 28910, 28974, 29038, 29102, 29166, 29230, 29294, 29358, 29422, 29486,
    29550, 29614, 29678, 29742, 29806, 29870, 29934, 29998, 30062, 30126, 30190, 30254,
    30318, 30382, 30446, 30510, 30574, 30638, 30702, 30766, 30830, 30894, 30958, 31022,
    31086, 31150, 31214, 31278, 31342, 31406, 31470, 31534, 31598, 31616, 31617, 31618,
    31619, 31620, 31621, 31622, 31623, 31624, 31625, 31626, 31627, 31628, 31629, 31630,
    31631, 31632, 31633, 31634, 31635, 31636, 31637, 31638, 31639, 31640, 31641, 31642,
    31643, 31644, 31645, 31646, 31647, 31648, 31649, 31650, 31651, 31652, 31653, 31654,
    31655, 31656, 31657, 31658, 31659, 31660, 31661, 31662, 31663, 31664, 31665, 31666,
    31667, 31668, 31669, 31670, 31671, 31672, 31673, 31674, 31675, 31676, 31677, 31678,
    31679, 31726, 31790, 31854, 31918, 31982, 32046, 32110, 32174, 32238, 32302, 32366,
    32430, 32494, 32558, 32622, 32686, 32750, 32814, 32878, 32942, 33006, 33070, 33134,
    33198, 33262, 33326, 33390, 33454, 33518, 33582, 33646, 33710, 33774, 33838, 33902,
    33966, 34030, 34094, 34158, 34222, 34286, 34350, 34414, 34478, 34542, 34606, 34670,
    34734, 34798, 34862, 34926, 34990, 35054, 35118, 35182, 35246, 35310, 35374, 35438,
    35502, 35566, 35630, 35694, 35712, 35713, 35714, 35715, 35716, 35717, 35718, 35719,
    35720, 35721, 35722, 35723, 35724, 35725, 35726, 35727, 35728, 35729, 35730, 35731,
    35732, 35733, 35734, 35735, 35736, 35737, 35738, 35739, 35740, 35741, 35742, 35743,
    35744, 35745, 35746, 35747, 35748, 35749, 35750, 35751, 35752, 35753, 35754, 35755,
    35756, 35757, 35758, 35759, 35760, 35761, 35762, 35763, 35764, 35765, 35766, 35767,
    35768, 35769, 35770, 35771, 35772, 35773, 35774, 35775, 35822, 35886, 35950, 36014,
    36078, 36142, 36206, 36270, 36334, 36398, 36462, 36526, 36590, 36654, 36718, 36782,
    36846, 36910, 36974, 37038, 37102, 37166, 37230, 37294, 37358, 37422, 37486, 37550,
    37614, 37678, 37742, 37806, 37870, 37934, 37998, 38062, 38126, 38190, 38254, 38318,
    38382, 38446, 38510, 38574, 38638, 38702, 38766, 38830, 38894, 38958, 39022, 39086,
    39150, 39214, 39278, 39342, 39406, 39470, 39534, 39598, 39662, 39726, 39790, 39808,
    39809, 39810, 39811, 39812, 39813, 39814, 39815, 39816, 39817, 39818, 39819, 39820,
    39821, 39822, 39823, 39824, 39825, 39826, 39827, 39828, 39829, 39830, 39831, 39832,
    39833, 39834, 39835, 39836, 39837, 39838, 39839, 39840, 39841, 39842, 39843, 39844,
    39845, 39846, 39847, 39848, 39849, 39850, 39851, 39852, 39853, 39854, 39855, 39856,
    39857, 39858, 39859, 39860, 39861, 39862, 39863, 39864, 39865, 39866, 39867, 39868,
    39869, 39870, 39871, 39918, 39982, 40046, 40110, 40174, 40238, 40302, 40366, 40430,
    40494, 40558, 40622, 40686, 40750, 40814, 40878, 40942, 41006, 41070, 41134, 41198,
    41262, 41326, 41390, 41454, 41518, 41582, 41646, 41710, 41774, 41838, 41902, 41966,
    42030, 42094, 42158, 42222, 42286, 42350, 42414, 42478, 42542, 42606, 42670, 42734,
    42798, 42862, 42926, 42990, 43054, 43118, 43182, 43246, 43310, 43374, 43438, 43502,
    43566, 43630, 43694, 43758, 43822, 43886, 43904, 43905, 43906, 43907, 43908, 43909,
    43910, 43911, 43912, 43913, 43914, 43915, 43916, 43917, 43918, 43919, 43920, 43921,
    43922, 43923, 43924, 43925, 43926, 43927, 43928, 43929, 43930, 43931, 43932, 43933,
    43934, 43935, 43936, 43937, 43938, 43939, 43940, 43941, 43942, 43943, 43944, 43945,
    43946, 43947, 43948, 43949, 43950, 43951, 43952, 43953, 43954, 43955, 43956, 43957,
    43958, 43959, 43960, 43961, 43962, 43963, 43964, 43965, 43966, 43967, 44014, 44078,
    44142, 44206, 44270, 44334, 44398, 44462, 44526, 44590, 44654, 44718, 44782, 44846,
    44910, 44974, 45038, 45102, 45166, 45230, 45294, 45358, 45422, 45486, 45550, 45614,
    45678, 45742, 45806, 45870, 45934, 45998, 46062, 46126, 46190, 46254, 46318, 46382,
    46446, 46510, 46574, 46638, 46702, 46766, 46830, 46894, 46958, 47022, 47086, 47150,
    47214, 47278, 47342, 47406, 47470, 47534, 47598, 47662, 47726, 47790, 47854, 47918,
    47982, 48000, 48001, 48002, 48003, 48004, 48005, 48006, 48007, 48008, 48009, 48010,
    48011, 48012, 48013, 48014, 48015, 48016, 48017, 48018, 48019, 48020, 48021, 48022,
    48023, 48024, 48025, 48026, 48027, 48028, 48029, 48030, 48031, 48032, 48033, 48034,
    48035, 48036, 48037, 48038, 48039, 48040, 48041, 48042, 48043, 48044, 48045, 48046,
    48047, 48048, 48049, 48050, 48051, 48052, 48053, 48054, 48055, 48056, 48057, 48058,
    48059, 48060, 48061, 48062, 48063, 48110, 48174, 48238, 48302, 48366, 48430, 48494,
    48558, 48622, 48686, 48750, 48814, 48878, 48942, 49006, 49070, 49134, 49198, 49262,
    49326, 49390, 49454, 49518, 49582, 49646, 49710, 49774, 49838, 49902, 49966, 50030,
    50094, 50158, 50222, 50286, 50350, 50414, 50478, 50542, 50606, 50670, 50734, 50798,
    50862, 50926, 50990, 51054, 51118, 51182, 51246, 51310, 51374, 51438, 51502, 51566,
    51630, 51694, 51758, 51822, 51886, 51950, 52014, 52078, 52096, 52097, 52098, 52099,
    52100, 52101, 52102, 52103, 52104, 52105, 52106, 52107, 52108, 52109, 52110, 52111,
    52112, 52113, 52114, 52115, 52116, 52117, 52118, 52119, 52120, 52121, 52122, 52123,
    52124, 52125, 52126, 52127, 52128, 52129, 52130, 52131, 52132, 52133, 52134, 52135,
    52136, 52137, 52138, 52139, 52140, 52141, 52142, 52143, 52144, 52145, 52146, 52147,
    52148, 52149, 52150, 52151, 52152, 52153, 52154, 52155, 52156, 52157, 52158, 52159,
    52206, 52270, 52334, 52398, 52462, 52526, 52590, 52654, 52718, 52782, 52846, 52910,
    52974, 53038, 53102, 53166, 53230, 53294, 53358, 53422, 53486, 53550, 53614, 53678,
    53742, 53806, 53870, 53934, 53998, 54062, 54126, 54190, 54254, 54318, 54382, 54446,
    54510, 54574, 54638, 54702, 54766, 54830, 54894, 54958, 55022, 55086, 55150, 55214,
    55278, 55342, 55406, 55470, 55534, 55598, 55662, 55726, 55790, 55854, 55918, 55982,
    56046, 56110, 56174, 56192, 56193, 56194, 56195, 56196, 56197, 56198, 56199, 56200,
    56201, 56202, 56203, 56204, 56205, 56206, 56207, 56208, 56209, 56210, 56211, 56212,
    56213, 56214, 56215, 56216, 56217, 56218, 56219, 56220, 56221, 56222, 56223, 56224,
    56225, 56226, 56227, 56228, 56229, 56230, 56231, 56232, 56233, 56234, 56235, 56236,
    56237, 56238, 56239, 56240, 56241, 56242, 56243, 56244, 56245, 56246, 56247, 56248,
    56249, 56250, 56251, 56252, 56253, 56254, 56255, 56302, 56366, 56430, 56494, 56558,
    56622, 56686, 56750, 56814, 56878, 56942, 57006, 57070, 57134, 57198, 57262, 57326,
    57390, 57454, 57518, 57582, 57646, 57710, 57774, 57838, 57902, 57966, 58030, 58094,
    58158, 58222, 58286, 58350, 58414, 58478, 58542, 58606, 58670, 58734, 58798, 58862,
    58926, 58990, 59054, 59118, 59182, 59246, 59310, 59374, 59438, 59502, 59566, 59630,
    59694, 59758, 59822, 59886, 59950, 60014, 60078, 60142, 60206, 60270, 60288, 60289,
    60290, 60291, 60292, 60293, 60294, 60295, 60296, 60297, 60298, 60299, 60300, 60301,
    60302, 60303, 60304, 60305, 60306, 60307, 60308, 60309, 60310, 60311, 60312, 60313,
    60314, 60315, 60316, 60317, 60318, 60319, 60320, 60321, 60322, 60323, 60324, 60325,
    60326, 60327, 60328, 60329, 60330, 60331, 60332, 60333, 60334, 60335, 60336, 60337,
    60338, 60339, 60340, 60341, 60342, 60343, 60344, 60345, 60346, 60347, 60348, 60349,
    60350, 60351, 60398, 60462, 60526, 60590, 60654, 60718, 60782, 60846, 60910, 60974,
    61038, 61102, 61166, 61230, 61294, 61358, 61422, 61486, 61550, 61614, 61678, 61742,
    61806, 61870, 61934, 61998, 62062, 62126, 62190, 62254, 62318, 62382, 62446, 62510,
    62574, 62638, 62702, 62766, 62830, 62894, 62958, 63022, 63086, 63150, 63214, 63278,
    63342, 63406, 63470, 63534, 63598, 63662, 63726, 63790, 63854, 63918, 63982, 64046,
    64110, 64174, 64238, 64302, 64366, 64384, 64385, 64386, 64387, 64388, 64389, 64390,
    64391, 64392, 64393, 64394, 64395, 64396, 64397, 64398, 64399, 64400, 64401, 64402,
    64403, 64404, 64405, 64406, 64407, 64408, 64409, 64410, 64411, 64412, 64413, 64414,
    64415, 64416, 64417, 64418, 64419, 64420, 64421, 64422, 64423, 64424, 64425, 64426,
    64427, 64428, 64429, 64430, 64431, 64432, 64433, 64434, 64435, 64436, 64437, 64438,
    64439, 64440, 64441, 64442, 64443, 64444, 64445, 64446, 64447, 64494, 64558, 64622,
    64686, 64750, 64814, 64878, 64942, 65006, 65070, 65134, 65198, 65262, 65326, 65390,
    65454, 65518],
  EXTENSIONS = [".txt", ".srt"],
  FILEEXEC = which ("file"),
  BACKUPEXT = "iso",
  FORCE = NULL,
  ISO = "ISO88597",
  EXIT_CODE = 0;

private define isiso (file)
{
  variable
    buf,
    fp = popen (sprintf ("%s \"%s\"", FILEEXEC, file), "r");

  () = fgets (&buf, fp);
 
  () = pclose (fp);

  return string_match (buf, "ISO-8859.+text");
}

private define file_callback (file, st, list)
{
  if (any (EXTENSIONS == path_extname (file)))
    if (isiso (file) || FORCE != NULL)
      list_append (list, file);

  return 1;
}

private define dir_callback (dir, st)
{
  return 1;
}

private define convert (file)
{
  variable
    i,
    ar,
    err,
    line,
    ic = iconv_open ("UTF8", ISO);

  ar = readfile (file);

  _for i (0, length (ar) - 1)
    {
    line  = ar[i];

    try (err)
      line = iconv (ic, line);
    catch AnyError:
      {
      variable c, l = line;
      line = "";
      _for c (0, strlen (l) - 1)
        {
        c = l[c];
        if (any (c == BLACKLIST))
          line += char (c);
        else
          line += iconv (ic, char (c));
        }
      }
  finally:
    ar[i] = strtrim_end (line);
    }
 
  if (NULL != BACKUPEXT && "no" != BACKUPEXT)
    if (-1 == copyfile (file, sprintf ("%s.%s", file, BACKUPEXT)))
      {
      EXIT_CODE = 1;
      tostderr (sprintf ("%s: failed to backup to `%s.%s', ERRNO: %s", file, file,
        BACKUPEXT));
      return;
      }
 
  %wrap it into a try, even if check had already become
  try (err)
    writefile (ar, file);
  catch AnyError:
    {
    tostderr (err.message);
    EXIT_CODE = 1;
    return;
    }

  tostdout (sprintf ("%s: converted", file));
}

define main ()
{
  variable
    i,
    fs,
    files,
    list = {},
    recursive = NULL,
    c = cmdopt_new (&_usage);

  c.add ("recursive", &recursive);
  c.add ("backup", &BACKUPEXT; type = "string");
  c.add ("force", &FORCE);
  c.add ("iso", &ISO;type = "string");
  c.add ("v|verbose", &verboseon);
  c.add ("info", &info);
  c.add ("help", &_usage);

  i = c.process (__argv, 1);

  if (FILEEXEC == NULL == FORCE)
    {
    tostderr ("file executable cannot be found");
    exit_me (1);
    }

  if (i == __argc)
    {
    tostderr ("Argument (filename) is required");
    exit_me (1);
    }

  files = __argv[[i:__argc - 1]];
  files = files[where (strncmp (files, "--", 2))];

  _for i (0, length (files) - 1)
    {
    if (-1 == access (files[i], F_OK))
      {
      tostderr (sprintf ("%s: doesn't exists in filesystem", files[i]));
      continue;
      }
 
    if (-1 == access (files[i], W_OK))
      {
      tostderr (sprintf ("%s: Is not writable", files[i]));
      continue;
      }
 
    if (_isdirectory (files[i]))
      {
      if (NULL == recursive)
        {
        tostderr (sprintf ("%s: is a directory and recursive is NULL", files[i]));
        continue;
        }

      fs = fswalk_new (&dir_callback, &file_callback; fargs = {list});
      fs.walk (files[i]);
      continue;
      }
 
    ifnot (isiso (files[i]))
      if (NULL == FORCE)
        {
        tostderr (sprintf ("%s: Is not an ISO text file", files[i]));
        EXIT_CODE = 1;
        continue;
        }

    list_append (list, files[i]);
    }
 
  if (length (list))
    array_map (Void_Type, &convert, list_to_array (list));
  else
    {
    tostderr ("No file to convert");
    EXIT_CODE = 1;
    }
 
  tostdout (sprintf ("EXIT CODE: %d", EXIT_CODE));

  exit_me (EXIT_CODE);
}
