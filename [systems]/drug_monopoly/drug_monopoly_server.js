/**
 * Config entries for this server script
 */

// number of days to remember for organisation influence
const DAYS_INFLUENCE = 15

// monopoly can be challenged after x days
const DAYS_SECURE_MONOPOLY = 2
const SECONDS_SECURE_MONOPOLY = DAYS_SECURE_MONOPOLY * 24 * 60 * 60

// option can be activated after x hours
const HOURS_COOLDOWN_OPTION = 24
const SECONDS_COOLDOWN_OPTION = HOURS_COOLDOWN_OPTION * 60 * 60

// TODO import zone id / names dynamically from Ora core
// Or make a selling_zones database table
const ZONE_NAMES = {
    1: "Vespucci Beach",
    2: "Place des cubes",
    3: "Maze Bank Arena",
    4: "Little Seoul",
    5: "Mirror park",
    6: "Sandy Shore",
    8: "Vinewood",
    7: "Paleto",
  }

// name => Not used for now
// points => total of influence points for this criteria
// fn => get criteria value from source data
INFLUENCE_INDICATORS = {
    quantity: [
        {
            name: 'Nombre d\'items vendus',
            fn: d => d.total_quantity,
            points: 10,
        },
        {
            name: 'Nombre d\'items vendus / jour d\'activité',
            fn: d => d.quantity_per_day,
            points: 5,
        },
        {
            name: 'Quantité max. atteinte en 1 jour',
            fn: d => d.max_quantity,
            points: 5,
        },
    ],
    quality: [
        {
            name: 'Valeur totale',
            fn: d => d.total_price,
            points: 5,
        },
        {
            name: 'Valeur moyenne / item',
            fn: d => d.price_per_item,
            points: 5,
        },
        {
            name: 'Valeur moyenne / jour d\'activité',
            fn: d => d.price_per_day,
            points: 5,
        },
        {
            name: 'Valeur max. atteinte en 1 jour',
            fn: d => d.max_price,
            points: 5,
        },
    ],
    stability: [
        {
            name: 'Stabilité de la quantité',
            fn: d => d.quantity_diff,
            points: 5,
            negative: true,
        },
        {
            name: 'Stabilité des prix',
            fn: d => d.price_diff,
            points: 5,
            negative: true,
        },
        {
            name: 'Ecart de quantité',
            fn: d => d.quantity_spread,
            points: 5,
            negative: true,
        },
        {
            name: 'Ecart de valeur',
            fn: d => d.price_spread,
            points: 5,
            negative: true,
        },
    ],
    frequency: [
        {
            name: 'Temps moyen entre deux items vendus',
            fn: d => d.minutes_per_item,
            points: 10,
            negative: true,
        },
        {
            name: 'Nombre de jours avec au moins une vente',
            fn: d => d.days_number,
            points: 10,
        },
    ],
    // domination section is hardcoded in the InfluenceCalculator.
    // still here for documentation / future improvements
    domination: [
        {
            name: 'Meilleur score quantité',
            points: 5,
        },
        {
            name: 'Meilleur score qualité',
            points: 5,
        },
        {
            name: 'Meilleur score stabilité',
            points: 5,
        },
        {
            name: 'Meilleur score fréquence',
            points: 5,
        },
    ],
}

/**
 * =============
 * DB operations / Functions
 * =============
 */

/**
 * Just a wrapper for mysql_fetch_all
 * @param {string} sql 
 * @param {object} params 
 * @param {function} cb 
 * @returns {void}
 */
 function sqlCallback(sql, params, cb = _ => {}) {
    return exports["mysql-async"].mysql_fetch_all(sql, params, cb)
}

/**
 * Just a wrapper for mysql_execute
 * @param {string} sql 
 * @param {object} params 
 */
function executeSql(sql, params) {
    exports["mysql-async"].mysql_execute(sql, params)
}

/**
 * Execute sql query with a Promise to handle results
 * @param {*} sql 
 * @param {*} params 
 * @returns {Promise}
 */
function fetchDb(sql, params) {
    return new Promise((resolve, reject) => {
        try {
            return sqlCallback(sql, params, res => {
                return resolve(res)
            })
        } catch(e) {
            console.error(e)
            reject(e)
        }
    })
}

/**
 * Some quick abstract crud
 * @param {string} table_suffix 
 * @param {Object} fieldsMap object key to db column
 * @returns Object
 */
const generateCrud = (table_suffix, fieldsMap) => {
    const table = ''+table_suffix
    const sanitizeKeys = input => {
        for(const k in input) {
            if(!Object.keys(fieldsMap).includes(k)) {
                throw new Error('Unknown field "'+ k + '" for ' + table_suffix)
            }
        }
    }
    const aliasKeys = map => Object.fromEntries(Object.entries(map).map(entr => ['@'+entr[0],entr[1]]))
    const buildSqlCriteria = criteria => Object.keys(criteria).map(k => `${fieldsMap[k]} = @${k}`).join(' AND ');

    return {
        create: values => {
            sanitizeKeys(values)
            let sql = `INSERT INTO ${table} (${Object.keys(values).map(k=>fieldsMap[k]).join(', ')})`
            sql += ` VALUES (${Object.keys(aliasKeys(values)).join(', ')})`
            return fetchDb(sql, values)
        },
        read: criteria => {
            sanitizeKeys(criteria)
            let sql = ``
            if(criteria != null || criteria != undefined) {
                sql = `SELECT ${Object.keys(fieldsMap).map(k => `${fieldsMap[k]} AS ${k}`).join(', ')} FROM ${table} WHERE ${buildSqlCriteria(criteria)}`
            } else {
                sql = `SELECT ${Object.keys(fieldsMap).map(k => `${fieldsMap[k]} AS ${k}`).join(', ')} FROM ${table}`
            }
            return fetchDb(sql, criteria)
        },
        update: (criteria, values) => {
            sanitizeKeys(criteria)
            sanitizeKeys(values)
            let sql = `UPDATE ${table} SET ${Object.keys(values).map(k => `${fieldsMap[k]} = @${k}`).join(',')} WHERE ${buildSqlCriteria(criteria)}`
            return fetchDb(sql, {...values, ...criteria})
        },
        delete: criteria => {
            sanitizeKeys(criteria)
            let sql = `DELETE FROM ${table} WHERE ${buildSqlCriteria(criteria)}`
            return fetchDb(sql, criteria)
        }
    }
}

const upsert = (crud,values) => {
    if (values.id) {
        crud.update({ id: values.id }, values)
    } else {
        crud.create({...values, id: null })
    }
}

const crud = {
    user: generateCrud('users', {
        id: 'id',
        steamId: 'identifier',
        uuid: 'uuid',
    }),
    organisationMember: generateCrud('organisation_member', {
        id: 'id',
        organisationId:'organisation_id',
        rankId: 'rank_id',
        playerUuid: 'uuid',
    }),
    bankAccount: generateCrud('banking_account', {
        id: 'id',
        uuid: 'uuid',
        iban: 'iban',
        amount: 'amount',
    }),
    transaction: generateCrud('drug_transaction', {
        id: 'id',
        zoneId: 'zone_id',
        organisationId: 'organisation_id',
        dayStamp: 'day_stamp',
        firstTime: 'first_time',
        lastTime: 'last_time',
        quantity: 'quantity',
        price: 'price',
    }),
    monopoly: generateCrud('drug_monopoly', {
        id: 'id',
        zoneId: 'zone_id',
        organisationId: 'organisation_id',
        timeBegin: 'time_begin',
        timeLastActivation: 'time_last_activation',
        slowRaiseStack: 'slow_raise_stack',
        fastRaiseStack: 'fast_raise_stack',
        influenceLock: 'influence_lock',
        lossStack: 'loss_stack',
        lossStackEnemies: 'loss_stack_enemies',
        quantityDouble: 'quantity_double',
        investStack: 'invest_stack',
        investLosing: 'invest_losing',
        investAmount: 'invest_amount',
        dollarLock: 'dollar_lock',
    }),
}

// custom crud helpers

// "day stamp" will change itself every 24h
const dayStamp = _ => Math.floor(Date.now() / (1000 * 60 * 60 * 24))
crud.transaction.readToday = (criteria) => {
    criteria.dayStamp = dayStamp()
    return crud.transaction.read(criteria)
}
crud.transaction.createToday = values => {
    values.dayStamp = dayStamp()
    return crud.transaction.create(values)
}


/**
 * Get mariadb timestamp value
 */
 function toIsoString(timestamp) {
    const date = new Date(timestamp)
    var tzo = -date.getTimezoneOffset(),
        dif = tzo >= 0 ? '+' : '-',
        pad = function(num) {
            return (num < 10 ? '0' : '') + num;
        };
    return date.getFullYear() +
        '-' + pad(date.getMonth() + 1) +
        '-' + pad(date.getDate()) +
        ' ' + pad(date.getHours()) +
        ':' + pad(date.getMinutes()) +
        ':' + pad(date.getSeconds())
  }


/**
 * ==========
 * Get useful player data
 * ==========
 */

function getSteamId(source) {
        const idMax = GetNumPlayerIdentifiers(source)
        let steamId
        for (let i= 0; i < idMax; i ++) {
            if (GetPlayerIdentifier(source, i).startsWith('steam:')) {
                steamId = GetPlayerIdentifier(source, i)
                break
            }
        }
        if (!steamId) { 
            console.error('Steam id not found for source ', playerId)
            return null
        }
        return steamId
}

async function getUuid(playerId) {
    const steamId = getSteamId(playerId)
    const user = await crud.user.read({ steamId })
    if (!user.length) {
        console.error('User not found with steam id ', steamId)
        return null
    }
    return  user[0].uuid
}

async function getOrgaId(playerId) {
    const uuid = await getUuid(playerId)
    const orga = await crud.organisationMember.read({ playerUuid: uuid })
    if (!orga.length) {
        console.error('Organisation id not found with player uuid ', uuid)
        return
    }
    return orga[0].organisationId
}

/**
 * ==========
 * Data collection
 * ==========
 */
function InfluenceDataCollector () {
    
    this.influenceData = {}

    this.refreshInfluenceData = async (zoneId=null) => {
        if (zoneId) { this.influenceData[zoneId] = await this.fetchData(zoneId) }
        else { this.influenceData = await this.fetchData() }
    }

    this.fetchData = async (zoneId = null) => {
        const rawData = await fetchDb(`SELECT
            stats.*,
            stats.total_price / stats.total_quantity price_per_item,
            sum(abs(tr.quantity - stats.quantity_per_day)) quantity_diff,
            sum(abs(tr.price - stats.price_per_day)) price_diff,
            stats.max_quantity - stats.min_quantity quantity_spread,
            stats.max_price - stats.min_price price_spread
        FROM drug_transaction tr
        LEFT JOIN (
                SELECT tr.zone_id, tr.organisation_id,
                    count(tr.id) days_number,
                    sum(tr.quantity) total_quantity,
                    avg(tr.quantity) quantity_per_day,
                    max(tr.quantity) max_quantity,
                    min(tr.quantity) min_quantity,
                    sum(tr.price) total_price,
                    avg(tr.price) price_per_day,
                    max(tr.price) max_price,
                    min(tr.price) min_price,
                    avg(TIMESTAMPDIFF(MINUTE,tr.first_time, tr.last_time)/tr.quantity) minutes_per_item
                FROM drug_transaction tr
                WHERE tr.first_time >= NOW() - INTERVAL ${DAYS_INFLUENCE} day
                ${zoneId ? 'AND tr.zone_id = @id' : ''}
                GROUP BY tr.zone_id, tr.organisation_id
            ) stats on stats.zone_id = tr.zone_id and stats.organisation_id = tr.organisation_id
        WHERE stats.days_number > 1 AND stats.total_quantity > 2 GROUP BY tr.zone_id, tr.organisation_id`, zoneId ? { '@id': zoneId } : {})
        if (!rawData) {
            console.error('Could not read transactions for zone id ', zoneId)
            return
        }
        if (zoneId) {
            return rawData
        }
        // group by zone_id and return
        return rawData.reduce((r, a) => {
            r[a.zone_id] = [...r[a.zone_id] || [], a];
            return r;
           }, {})
    }

    this.getZoneData = (zoneId = null) => {
        if (zoneId) {
            return this.influenceData[zoneId]
        } else {
            return this.influenceData
        }
    }
}

/**
 * ==========
 * Influence calculation
 * ==========
 */

function InfluenceCalculator (influenceDataCollector) {

    this.influenceDataCollector = influenceDataCollector

    // Store current influence score results for each zone in server memory
    this.influenceResults = {}

    this.refreshInfluenceResults = async (zoneId = null) => {
        await this.influenceDataCollector.refreshInfluenceData(zoneId)
        if (zoneId) {
            this.computeZone(zoneId)
        } else {
            this.computeAllZones()
        }
    }


    this.computeAllZones = _ => {
        for (const zoneId in ZONE_NAMES) {
            this.computeZone(zoneId)
        }
    }


    this.addOrgaInfluence = (zoneId, orgaId, category, points, title) => {
        const init = (s,k,v) => { if (!s[k]) { s[k] = v } }
        init(this.influenceResults, zoneId, {})
        init(this.influenceResults[zoneId], orgaId, { organisation_id: orgaId, scores: { total: 0, quantity: 0, quality: 0, stability: 0, frequency: 0, domination: 0 } })
        this.influenceResults[zoneId][orgaId].scores[category] += points
        this.influenceResults[zoneId][orgaId].scores.total += points
        // debug
        // console.log(orgaId, zoneId, title, '+'+points+'='+this.influenceResults[zoneId][orgaId].total)
    }

    this.computeZone = zoneId => {
        this.influenceResults[zoneId] = null
        const data = this.influenceDataCollector.getZoneData(zoneId)
        if(!data || !data.length || !data[0].zone_id) {
            // no influence data, nothing to do
            return
        }

        for (const categoryName in INFLUENCE_INDICATORS) {
            if (categoryName == 'domination') { continue }
            const category = INFLUENCE_INDICATORS[categoryName]
            for (const i of category) {
                let scores = []
                for (const line of data) {
                    scores.push({ organisation_id: line.organisation_id, score: i.fn(line) })
                }
                scores = scores.filter(s => s.score > 0)
                    .sort((a,b) => i.negative ? (a.score - b.score) : (b.score - a.score))
                if (scores.length > 1) {
                    const diff = scores[1].score / scores[0].score
                    let ratio1 = 100
                    let ratio2 = 0
                    if (diff == 1) {
                        ratio2 = 50
                        ratio1 = 50
                    } else if (diff >= 0.9) {
                        ratio2 = 30
                        ratio1 = 70
                    } else if (diff >= 0.75) {
                        ratio2 = 20
                        ratio1 = 80
                    }
                    this.addOrgaInfluence(zoneId, scores[0].organisation_id, categoryName, i.points * ratio1 / 100, i.name)
                    this.addOrgaInfluence(zoneId, scores[1].organisation_id, categoryName, i.points * ratio2 / 100, i.name)
                } else if (scores.length == 1) {
                    this.addOrgaInfluence(zoneId, scores[0].organisation_id, categoryName, i.points, i.name)
                }
            }
        }

        for (const orgaId in this.influenceResults[zoneId]) {
            const orgaScores = this.influenceResults[zoneId][orgaId].scores
            if (orgaScores.total === 0) { continue }
            const criteriaMap = {
                quantity: 'quantité',
                quality: 'qualité',
                stability: 'stabilité',
                frequency: 'fréquence',
            }
            for (const categoryName in criteriaMap) {
                if (orgaScores[categoryName] > 10) {
                    this.addOrgaInfluence(zoneId, orgaId, 'domination', 5, 'Meilleur score '+criteriaMap[categoryName], )
                }
            }
        }
    }
}

/**
 * ==========
 * Monopoly attribution, option activations & high level operations
 * ==========
 */
function MonopolyService(influenceCalculator, clientNotif) {
    
    this.influenceCalculator = influenceCalculator
    this.clientNotif = clientNotif

    this.monopolyData = []
    
    this.influenceChanged = async zoneId => {
        await this.influenceCalculator.refreshInfluenceResults(zoneId)
        await this.updateMonopolyFromInfluence(zoneId)
        await this.monopolyChanged()
    }

    this.monopolyChanged = async zoneId => {
        await this.fetchDbMonopolyData(zoneId)
        for (const orgaId in playersList) {
            for (const playerId of playersList[orgaId]) {
                this.clientNotif.emitZoneData(playerId, zoneId, this.formatMonopolyData(zoneId, orgaId))
            }
        }
    }

    this.fetchDbMonopolyData = async (zoneId = null)  => {
        if (zoneId) {
            const res = await crud.monopoly.read({ zoneId })
            const currentIndex = this.monopolyData.findIndex(m => m.zoneId == zoneId)
            if (currentIndex > -1) {
                if (res && res[0]) {
                    this.monopolyData.splice(currentIndex, 1, res[0])
                } else {
                    this.monopolyData.splice(currentIndex, 1)
                }
            } else if (res && res[0]) {
                this.monopolyData.push(res[0])
            }
        } else { this.monopolyData = await crud.monopoly.read() }
    }

    this.findMonopolyData = zoneId => {
        return this.monopolyData.find(l => l.zoneId == zoneId)
    }

    this.updateMonopolyFromInfluence = async zoneId => {
        const currentMonopoly = this.findMonopolyData(zoneId)
        // if monopoly exists and is protected, log it and stop
        if (currentMonopoly && (Date.now() - currentMonopoly.timeBegin)/1000 < SECONDS_SECURE_MONOPOLY) {
            console.log('Monopoly is still protected in zone ' + zoneId)
            return
        }
        const zoneData = this.getZoneInfluences(zoneId)
        let bestOrga = []
        // get winner (sort organisations by total influence desc)
        if (zoneData) {
            bestOrga = Object.values(zoneData).sort((a,b) => b.scores.total - a.scores.total)
        }
        // if there is no winner, remove monopoly and stop
        if (!bestOrga.length || bestOrga[0] <= 50) {
            if (currentMonopoly) {
                console.log('Organisation ',  currentMonopoly.organisationId, ' lost monopoly for zone ', zoneId)
                await this.removeMonopoly(zoneId)
            }
            return
        }
        // if winner already has monopoly, nothing to do
        if (currentMonopoly && bestOrga[0].organisation_id == currentMonopoly.organisationId) {
            return
        }
        // If we identified a new winner, transfer monopoly
        await this.unlockMonopoly(zoneId, bestOrga[0].organisation_id, currentMonopoly)
    }

    this.unlockMonopoly = async (zoneId, orgaId, currentMonopoly = null) => {
        if (currentMonopoly) {
            console.log('Organisation ',  currentMonopoly.organisationId, ' lost monopoly for zone ', zoneId)
            await this.removeMonopoly(zoneId)
        }
        await crud.monopoly.create({ zoneId, organisationId: orgaId, })
        console.log('Organisation ', orgaId, ' got monopoly for zone ', zoneId)
    }

    this.removeMonopoly = async (zoneId) => {
        await crud.monopoly.delete({ zoneId: zoneId })
    }

    this.getPriceModifier = (zoneId, orgaId) => {
        const m = this.findMonopolyData(zoneId)
        if (!m) {
            // no monopoly found for this zone
            return 1
        }

        if (m.organisationId != orgaId) {
            return 1 + m.lossStackEnemies / 100
        }

        return 1 + (
            m.slowRaiseStack
            + m.fastRaiseStack
            + m.lossStack
            + m.investStack
        ) / 100
    }

    // Utils
    this.randomValue = (min, max) => Math.floor(Math.random() * (max - min + 1)) + min
    this.risk = percent => this.randomValue(1,100) <= percent
    this.limit = (min, max) => value => Math.min(max, Math.max(min, value))

    /**
     * Activates a monopoly option
     * @param {number} zoneId 
     * @param {string} optionCode 
     * @param {string} uuid 
     * @param {number} orgaId 
     * @returns {Promise} a message for success or failure
     */
    this.activateOption = async (zoneId, optionCode, uuid=null, orgaId = null) => {
        const raw = await crud.monopoly.read({ zoneId })
        if (!raw.length) {
            console.error('Cannot activate option without an active monopoly')
            return
        }
        const m = raw[0]
        const reinit = (...keys) => keys.forEach(k => ({
            slowRaiseStack: _ => {
                if (m[k] < 10) {
                    m[k] = Math.min(5, m[k])
                } else {
                    m[k] = Math.min(10, m[k])
                }
            },
            fastRaiseStack: _ => {
                m[k] = 0
                m.influenceLock = false
            },
            lossStack: _ => {
                m[k] = 0
                m.lossStackEnemies = 0
                m.quantityDouble = false
            },
            investStack: _ => {
                m[k] = Math.min(0, m[k])
                if (m.investLosing && this.risk(67)) {
                    m.investLosing = false
                }
            }
        }[k]()))
        // notification de retour pour le joueur
        let message = ""
        switch(optionCode) {
            case 'slow_raise':
                reinit('fastRaiseStack', 'lossStack', 'investStack')
                if (m.slowRaiseStack >= 10) {
                    if (this.risk(33)) {
                        m.slowRaiseStack = this.limit(0,20)(m.slowRaiseStack - 1)
                        message = "ECHEC - T'as été obligé de baisser un peu tes prix."
                    } else {
                        m.slowRaiseStack = this.limit(0,20)(m.slowRaiseStack + 2)
                        message = "SUCCES - Les prix augmentent légèrement."
                    }
                } else {
                    m.slowRaiseStack = this.limit(0,10)(m.slowRaiseStack + 2)
                    message = "SUCCES - Les prix augmentent légèrement."
                }
                break
            case 'fast_raise':
                reinit('slowRaiseStack', 'lossStack', 'investStack')
                m.influenceLock = true
                if (m.fastRaiseStack >= 15) {
                    if (this.risk(10 + m.fastRaiseStack)) {
                        m.fastRaiseStack = 0
                        message = "ECHEC - La négociation repart à zéro."
                    } else {
                        m.fastRaiseStack = this.limit(0,25)(m.fastRaiseStack + this.randomValue(6, 10))
                        message = "SUCCES - Les prix augmentent."
                    }
                } else {
                    m.fastRaiseStack = this.limit(0, 15)(m.fastRaiseStack + this.randomValue(6, 10))
                    message = "SUCCES - Les prix augmentent. Arrêt des gains d'influence."
                }
                break
            case 'loss':
                reinit('slowRaiseStack', 'fastRaiseStack', 'investStack')
                m.lossStack = this.randomValue(-55, -45)
                m.lossStackEnemies = m.lossStack
                message = "SUCCES - Les prix diminuent pour toutes les factions."
                break
            case 'cut':
                reinit('slowRaiseStack', 'fastRaiseStack', 'investStack')
                if (this.risk(20)) {
                    m.lossStack = this.limit(-80, -40)(m.lossStack - this.randomValue(5, 8))
                    message = "ECHEC - Les prix diminuent pour ta faction."
                } else {
                    m.lossStack = this.limit(-55, -40)(m.lossStack + this.randomValue(2, 4))
                    message = "SUCCES - La baisse des prix est réduite pour ta faction."
                }
                break
            case 'double':
                reinit('slowRaiseStack', 'fastRaiseStack', 'investStack')
                if (this.risk(50)) {
                    m.lossStack = this.randomValue(-60, -80)
                    message = "ECHEC - Baisse des prix pour ta faction. Quantités doublées."
                }
                m.quantityDouble = true
                if (message.length == 0) {
                    message = "SUCCES - Quantités doublées."
                }
                break
            case 'invest':
                m.dollarLock = true
                reinit('slowRaiseStack', 'fastRaiseStack', 'lossStack')
                if (this.risk(7)) {
                    m.investStack -= this.randomValue(1, 4)
                    m.investLosing = true
                    message = "ECHEC - Un client te répond plus. La valeur des dettes baisse."
                } else {
                    m.investStack += this.randomValue(1, 2)
                    message = "SUCCES - La valeur des dettes augmente."
                }
                break
            case 'save_invest':
                reinit('slowRaiseStack', 'fastRaiseStack', 'lossStack')
                if (this.risk(33)) {
                    m.investStack -= this.randomValue(2, 3)
                    message = "ECHEC - Tes clients te laissent en vu. La valeur des dettes baisse."
                } else {
                    m.investStack += this.randomValue(1, 2)
                    m.investLosing = false
                    message = "SUCCES - La valeur des dettes augmente."
                }
                break
            case 'collect':
                reinit('slowRaiseStack', 'fastRaiseStack', 'lossStack')
                const totalValue = Math.floor(m.investAmount * this.getPriceModifier(zoneId, orgaId))
                const account = await crud.bankAccount.read({ uuid })
                if (account && account[0]) {
                    await crud.bankAccount.update({ id: account[0].id } , { amount: account[0].amount + totalValue })
                    const oldIllegalAmount = (await crud.bankAccount.read({ iban: 'illegalaccount' }))
                    if (oldIllegalAmount && oldIllegalAmount[0]) {
                        await crud.bankAccount.update({ iban: 'illegalaccount' } ,
                            { amount: oldIllegalAmount[0].amount - totalValue })
                    }
                } else {
                    console.error('Cannot read player bank account', uuid)
                    return
                }
                m.investStack = 0
                m.investAmount = 0
                m.investLosing = false
                m.dollarLock = false
                message = "SUCCES - Tu reçois un virement de " + totalValue + "$."
                break

            default:
                console.error('Unknown monopoly option code "'+ optionCode +'"')
                break
        }
        delete m.timeBegin
        m.timeLastActivation = toIsoString(Date.now())
        await crud.monopoly.update({ id: m.id }, m)
        await this.monopolyChanged(zoneId)
        return message
    }

    this.getZoneInfluences = zoneId => {
        if (!this.influenceCalculator.influenceResults.hasOwnProperty(zoneId)) {
            return []
        }
        return this.influenceCalculator.influenceResults[zoneId]
    }
    this.getOrgaInfluenceScores = (zoneId, orgaId) => {
        const defaultScores = {
            quantity: 0,
            quality: 0,
            stability: 0,
            frequency: 0,
            domination: 0,
        }
        const zone = this.getZoneInfluences(zoneId)
        if (!zone) { return defaultScores }
        const orgaInfluenceData = zone[orgaId]
        if (!orgaInfluenceData) { return defaultScores }
        return orgaInfluenceData.scores
    }

    this.getTotalInfluence = (zoneId, orgaId) => {
        const orga = this.getOrgaInfluenceScores(zoneId, orgaId)
        if (!orga) { return 0 }
        return orga.total
    }

    this.formatMonopolyData = (zoneId, orgaId) => {
        const data = {
            influence: this.getTotalInfluence(zoneId, orgaId),
            scores: this.getOrgaInfluenceScores(zoneId, orgaId),
            priceModifier: this.getPriceModifier(zoneId, orgaId),
            monopoly: false,
            canActivateOption: false,
            double: false,
            influenceLock: false,
            dollarLock: false,
        }
        const m = this.findMonopolyData(zoneId)
        // no monopoly exist => default data
        if (!m) {
            return data
        }
        // monopoly is not owned by this orga => they get double quantity info
        data.double = !!m.quantityDouble
        if (m.organisationId != orgaId) {
            return data
        }
        data.influenceLock = !!m.influenceLock
        data.dollarLock = !!m.dollarLock
        // orga is monopoly owner => they get options details
        data.monopoly = true
        data.canActivateOption = (Date.now() - m.timeLastActivation)/1000 > SECONDS_COOLDOWN_OPTION
        data.options = {
            slowRaise: {
                value: m.slowRaiseStack,
                step: m.slowRaiseStack < 10 ? 1 : 2,
            },
            fastRaise: {
                value: m.fastRaiseStack,
                step: m.fastRaiseStack < 15 ? 1 : 2,
            },
            loss: {
                value: m.lossStack,
                enemyValue: m.lossStackEnemies,
                double: m.quantityDouble,
                step: m.lossStack < 0 ? 2 : 1,
            },
            invest: {
                value: m.investStack,
                losing: m.investLosing,
                amount: m.investAmount,
                step: (m.investStack != 0 || m.investAmount > 0) ? 2 : 1,
            },
        }
        return data
    }

    this.getAllZonesFormattedData = orgaId => {
        const data = {}
        for (const zoneId in ZONE_NAMES) {
            data[zoneId] = this.formatMonopolyData(zoneId, orgaId)
        }
        return data
    }

    this.maybeNotifyEnemies = (zoneId, orgaId) => {
        if (this.getTotalInfluence(zoneId, orgaId) < 15) {
            for (const orgaId in playersList) {
                const infl = this.getTotalInfluence(zoneId, orgaId)
                if (infl > 30 && this.risk(this.limit(20, 50)(infl - 10))) {
                    this.clientNotif.notifyOrga(orgaId, "INFO - Salut mec, une équipe que je connais pas veut me vendre sa came à " + ZONE_NAMES[zoneId])
                }
            }
        }
    }
    
    this.registerTransaction = async (zoneId, organisationId, price) => {
        const data = monopolyService.formatMonopolyData(zoneId, organisationId)
        const quantity = 1 + data.double
        if (data.dollarLock) {
            await crud.monopoly.update({ zoneId }, { investAmount: data.options.invest.amount + price })
        }
        if (!data.influenceLock) {
            const currentTransaction = await crud.transaction.readToday({ zoneId, organisationId })
            if (currentTransaction.length) {
                await crud.transaction.update({ id: currentTransaction[0].id }, {
                    quantity: currentTransaction[0].quantity + quantity,
                    price: currentTransaction[0].price + price,
                })
            } else {
                await crud.transaction.createToday({ zoneId, organisationId, quantity, price })
            }
        }
        await this.influenceChanged(zoneId)
        this.maybeNotifyEnemies(zoneId, organisationId)
    }
}

/**
 * ==========
 * Client interaction
 * ==========
 */

function ClientCommunicator () {

    this.emitZoneData = (playerId=null, zoneId=null, zoneData = {}) => {
        emitNet('drug_monopoly:updateZoneInfo', playerId || -1, zoneId, zoneData)
    }

    // TODO notify player with a text message on his phone, instead of hud notification

    this.notifyPlayer = (playerId, message) => {
        emitNet('drug_monopoly:sendMessageNotification', playerId, message)
    }

    this.notifyOrga = (orgaId, message) => {
        const playerIds = playersList[orgaId]
        if (playerIds) {
            for (const p of playerIds) {
                this.notifyPlayer(p, message)
            }
        }
    }
}

/**
 * ==========
 * Script entrypoint
 * ==========
 */

const clientNotif = new ClientCommunicator()

const dataCollector = new InfluenceDataCollector()
const influenceCalculator = new InfluenceCalculator(dataCollector)
const monopolyService = new MonopolyService(influenceCalculator, clientNotif)


// Apply new data, new script update, new timeframe when script was restarted
monopolyService.fetchDbMonopolyData().then(_ => {
    for (const zone in ZONE_NAMES) {
        monopolyService.influenceChanged(zone)
    }
})


/**
 * ==========
 * Events
 * ==========
 */
// hold players list by faction
const playersList = {}
onNet('Ora::CE::Character:Loaded', async _ => {
    const playerId = source
    const organisationId = await getOrgaId(playerId)
    if (organisationId) {
        if (!playersList[organisationId]) { playersList[organisationId] = []}
        if (!playersList[organisationId].includes(playerId)) { playersList[organisationId].push(playerId) }
        clientNotif.emitZoneData(playerId, null, monopolyService.getAllZonesFormattedData(organisationId))
    }
})
on('playerDropped', async _ => {
    const playerId = source
    const organisationId = await getOrgaId(playerId)
    if (organisationId && playersList[organisationId]) {
        const idx = playersList[organisationId].indexOf(playerId)
        if (idx > -1) {
            playersList[organisationId].splice(idx, 1)
        }
    }
})

onNet('drug_monopoly:requestMonopolyUpdate', async zoneId => {
    if (!source) { return }
    clientNotif.emitZoneData(source, zoneId, monopolyService.formatMonopolyData(zoneId, await getOrgaId(source)))
})

onNet('drug_monopoly:newTransaction', async (zoneId, price) => {
    const playerId = source
    const organisationId = await getOrgaId(playerId)
    if (!organisationId) {
        console.error('player selling without organisation')
        return
    }
    await monopolyService.registerTransaction(zoneId, organisationId, price)
})

onNet('drug_monopoly:activateOption', async (zoneId, optionCode) => {
    const playerId = source
    const uuid = await getUuid(playerId)
    const organisationId = await getOrgaId(playerId)
    const message = await monopolyService.activateOption(zoneId, optionCode, uuid, organisationId)
    clientNotif.notifyOrga(organisationId, "Option activée à " + ZONE_NAMES[zoneId] + " : " + message)
})
